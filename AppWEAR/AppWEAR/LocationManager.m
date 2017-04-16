//
//  LocationManager.m
//  AppWEAR
//
//  Created by HKM on 27/02/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "LocationManager.h"
#import <UIKit/UIKit.h>
#import "LoggedInUser.h"
#import "Reachability.h"
#import "WebApiHandler.h"
#import "IQUIWindow+Hierarchy.h"
#import "AppDelegate.h"

NSString *const kLocationUpdateNotification     =       @"LocationUpdateNotification";
NSString *const kLocationPlacemark              =       @"LocationPlacemark";
static const NSUInteger kTimeInterval = 30.0;

@interface LocationManager ()
{
    NSTimer *timer;
}

@property (nonatomic, strong, readwrite) CLLocation *currentLocation;

@end

@implementation LocationManager

@synthesize recentPlacemark = recentPlacemark;
@synthesize locationManager = locationManager;

+(instancetype)sharedManager
{
    static LocationManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[LocationManager alloc] init];
    });
    return manager;
}

-(instancetype)init
{
    self = [super init];
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    [self startLocationUpdate];
    timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(updateLocationOnServer) userInfo:nil repeats:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    return self;
}

-(void)stopLocationManager
{
    if (locationManager)
    {
        [locationManager stopUpdatingLocation];
        locationManager.delegate = nil;
        locationManager = nil;
    }
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)dealloc
{
    [self stopLocationManager];
}

-(void)startLocationUpdate
{
    locationManager.delegate = self;
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [locationManager requestAlwaysAuthorization];
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please allow to access your location, so that App can work well." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [[[AppDelegate sharedDelegate].window currentViewController] presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [locationManager startUpdatingLocation];
            break;
            
        default:
            break;
    }
}

#pragma mark App Transitions

-(void)appDidEnterBackground:(NSNotification *)notification
{
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
}

-(void)appDidBecomeActive:(NSNotification *)notification
{
    if ([LoggedInUser loggedInUser])
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(updateLocationOnServer) userInfo:nil repeats:YES];
    }
}


#pragma mark Update Location On Server

-(void)updateLocationOnServer
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:kMessageNetworkNotAvailable preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [[[AppDelegate sharedDelegate].window currentViewController] presentViewController:alertController animated:YES completion:nil];
        return;
    }
    else
    {
        LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
        if ([LoggedInUser loggedInUser] && recentPlacemark)
        {
            NSString *latitude = [NSString stringWithFormat:@"%0.4lf", recentPlacemark.location.coordinate.latitude];
            NSString *longitude = [NSString stringWithFormat:@"%0.4lf", recentPlacemark.location.coordinate.longitude];
            NSString *address = [NSString stringWithFormat:@"%@, %@", recentPlacemark.name, recentPlacemark.locality];

            NSDictionary *parameters = @{kAccess_Token : loggedInUser.accessToken, kLatitude : latitude, kLongitude : longitude, kAddress : address};
            [[WebApiHandler sharedHandler] updateUserLocationWithParameters:parameters success:^(NSDictionary *response) {
//                NSLog(@"%@", response);
            } failure:^(NSError *error) {
//                NSLog(@"%@", error.localizedDescription);
            }];
        }
    }
}

#pragma mark CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please allow to access your location, so that App can work well." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [[[AppDelegate sharedDelegate].window currentViewController] presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [locationManager startUpdatingLocation];
            break;
            
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (locations.count > 0)
    {
        __weak typeof (self) weakSelf = self;
        CLLocation *location = locations.firstObject;
        self.currentLocation = location;
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            __block CLPlacemark *placemark = placemarks.lastObject;
            __strong typeof (weakSelf) strongSelf = weakSelf;
            strongSelf->recentPlacemark = placemark;
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kLocationUpdateNotification object:self userInfo:@{kLocationPlacemark : placemark}];
            });
        }];
    }
}

@end
