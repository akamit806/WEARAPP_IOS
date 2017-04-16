//
//  NewTrialViewController.m
//  AppWEAR
//
//  Created by HKM on 05/03/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "NewTrailViewController.h"
#import <MapKit/MapKit.h>
#import "LocationManager.h"
#import "JPSThumbnailAnnotation.h"
#import "WebApiHandler.h"
#import "LoggedInUser.h"

typedef NS_ENUM(NSInteger, TrailStatus)
{
    TrailStatusStart = 1,
    TrailStatusUpdate,
    TrailStatusEnd
};

static const NSUInteger kTrailUpdateTimeInterval = 30.0;

@interface NewTrailViewController () <MKMapViewDelegate>
{
    BOOL isTrailRunning;
    NSTimer *timer;
    NSString *trailId;
    NSMutableArray *locations;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapViewTrail;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrailStart;
@property (strong, nonatomic) MKPolyline *polyline;

@end

@implementation NewTrailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapViewTrail.delegate = self;
    trailId = @"0";
    CLLocation *location = [LocationManager sharedManager].currentLocation;
    [self zoomMapViewForCoordinate:location.coordinate latitudeDelta:0.01 longitudeDelta:0.01];
}

-(void)startTrailOperation
{
    if (self.polyline)
    {
        [self.mapViewTrail removeOverlay:self.polyline];
    }
    
    isTrailRunning = YES;
    [_buttonTrailStart setTitle:@"STOP" forState:UIControlStateNormal];
    
    CLLocation *location = [LocationManager sharedManager].currentLocation;
    locations = [NSMutableArray new];
    [self zoomMapViewForCoordinate:location.coordinate latitudeDelta:0.01 longitudeDelta:0.01];
    JPSThumbnail *thumbnail = [[JPSThumbnail alloc] init];
    thumbnail.title = @"";
    NSString *pinImagePath = [[NSBundle mainBundle] pathForResource:@"pin" ofType:@"png"];
    thumbnail.profilePicURL = [NSURL fileURLWithPath:pinImagePath];
    thumbnail.coordinate = location.coordinate;
    [_mapViewTrail addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:thumbnail]];
    [self updateTrailDataOnServerWithStatus:TrailStatusStart];
}

-(void)addPolyLineOnMapWithLocation:(CLLocation *)location
{
    [locations addObject:location];
    NSUInteger count = [locations count];
    
    if (count > 1)
    {
        CLLocationCoordinate2D coordinates[count];
        for (NSInteger i = 0; i < count; i++)
        {
            coordinates[i] = [(CLLocation *)locations[i] coordinate];
        }
        
        MKPolyline *oldPolyline = self.polyline;
        self.polyline = [MKPolyline polylineWithCoordinates:coordinates count:count];
        [self.mapViewTrail addOverlay:self.polyline];
        if (oldPolyline)
        {
            [self.mapViewTrail removeOverlay:oldPolyline];
        }
    }
}

-(void)stopTrailOperation
{
    CLLocation *location = [LocationManager sharedManager].currentLocation;
    JPSThumbnail *thumbnail = [[JPSThumbnail alloc] init];
    thumbnail.title = @"";
    NSString *pinImagePath = [[NSBundle mainBundle] pathForResource:@"pin" ofType:@"png"];
    thumbnail.profilePicURL = [NSURL fileURLWithPath:pinImagePath];
    thumbnail.coordinate = location.coordinate;
    [_mapViewTrail addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:thumbnail]];
    
    [self updateTrailDataOnServerWithStatus:TrailStatusEnd];
    isTrailRunning = NO;
    [_buttonTrailStart setTitle:@"START" forState:UIControlStateNormal];
    trailId = @"0";
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
}

-(void)updateTrailDataOnServerWithStatus:(TrailStatus)status
{
    CLPlacemark *placemark = [LocationManager sharedManager].recentPlacemark;
    [self addPolyLineOnMapWithLocation:[placemark.location copy]];
    NSString *latitude = [NSString stringWithFormat:@"%0.4lf", placemark.location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%0.4lf", placemark.location.coordinate.longitude];
    NSString *name = [NSString stringWithFormat:@"%@", placemark.name];
    NSString *trailDate = [appDateFormatter() stringFromDate:[NSDate date]];
    NSString *trailStatus;
    switch (status)
    {
        case TrailStatusStart:
        {
            trailId = @"0";
            trailStatus = @"1";
        }
            break;
        case TrailStatusUpdate:
        {
            trailStatus = @"2";
        }
            break;
        case TrailStatusEnd:
        {
            trailStatus = @"3";
        }
            break;
            
        default:
            break;
    }
    
    NSDictionary *parameters = @{kAccess_Token : [LoggedInUser loggedInUser].accessToken, kLatitude : latitude, kLongitude : longitude, kTrial_Name : name, kTrial_Date : trailDate, kTrial_Id : trailId, kTrial_Status : trailStatus};
    __weak typeof (self) weakSelf = self;
    [[WebApiHandler sharedHandler] saveTrailWithParameters:parameters success:^(NSDictionary *response) {
        if ([[response objectForKey:kCode] intValue] == 200 && [[response valueForKey:kResponse] isEqualToString:@"Success"])
        {
            __strong typeof (weakSelf) strongSelf = weakSelf;
            strongSelf->trailId = [response objectForKey:kId];
            if (status == TrailStatusStart)
            {
                strongSelf->timer = [NSTimer scheduledTimerWithTimeInterval:kTrailUpdateTimeInterval target:self selector:@selector(updateTrailOnServer) userInfo:nil repeats:YES];
            }
        }
        
    } failure:^(NSError *error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    }];
}

-(void)updateTrailOnServer
{
    [self updateTrailDataOnServerWithStatus:TrailStatusUpdate];
}

- (IBAction)trailButtonClicked:(UIButton *)sender
{
    if (!isTrailRunning)
    {
        [self startTrailOperation];
    }
    else
    {
        [self stopTrailOperation];
    }
}

-(void)zoomMapViewForCoordinate:(CLLocationCoordinate2D)coordinate latitudeDelta:(CLLocationDegrees)latDelta longitudeDelta:(CLLocationDegrees)longDelta
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = latDelta;
    span.longitudeDelta = longDelta;
    region.span = span;
    region.center = coordinate;
    [_mapViewTrail setRegion:region animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        renderer.strokeColor = [UIColor colorWithRed:86.0/255.0 green:177.0/255.0 blue:246.0/255.0 alpha:1.0];
        renderer.lineWidth   = 3;
        
        return renderer;
    }
    
    return nil;
}

@end
