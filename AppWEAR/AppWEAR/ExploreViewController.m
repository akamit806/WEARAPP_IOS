//
//  ExploreViewController.m
//  AppWEAR
//
//  Created by HKM on 25/01/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "ExploreViewController.h"
#import <MapKit/MapKit.h>
#import "ExploreTableViewCell.h"
#import "UserAnnotation.h"
#import "JPSThumbnailAnnotation.h"

@interface ExploreViewController () <MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *users;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableViewFriends;
@property (weak, nonatomic) IBOutlet UILabel *labelNoData;

@end

@implementation ExploreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"EXPLORE";
    [self addLeftSideMenuButton];
    
    _tableViewFriends.tableFooterView = [UIView new];
    _mapView.delegate = self;
    [self getUsers];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (IBAction)refreshButtonClicked:(UIButton *)sender
{
    [self getUsers];
}

-(void)getUsers
{
    CLPlacemark *placemark = [[LocationManager sharedManager] recentPlacemark];
    if (placemark)
    {
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        region.span = span;
        region.center = placemark.location.coordinate;
        [_mapView setRegion:region animated:YES];
        
        JPSThumbnail *thumbnail = [[JPSThumbnail alloc] init];
        thumbnail.title = [NSString stringWithFormat:@"%@ %@", [LoggedInUser loggedInUser].firstName, [LoggedInUser loggedInUser].lastName];
        NSString *pinImagePath = [[NSBundle mainBundle] pathForResource:@"pin" ofType:@"png"];
        thumbnail.profilePicURL = pinImagePath;
        thumbnail.coordinate = [[LocationManager sharedManager] recentPlacemark].location.coordinate;
        thumbnail.disclosureBlock = ^{ NSLog(@"selected Empire"); };
        [_mapView addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:thumbnail]];
        
        NSString *latitude = [NSString stringWithFormat:@"%0.4lf", placemark.location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%0.4lf", placemark.location.coordinate.longitude];
        NSDictionary *parameters = @{kAccess_Token : [LoggedInUser loggedInUser].accessToken, kLatitude : latitude, kLongitude : longitude, kDistance : @"10"};
        __weak typeof (self) weakSelf = self;
        [SVProgressHUD showWithStatus:@"Getting Users..."];
        [[WebApiHandler sharedHandler] getUsersByRadiusWithParameters:parameters success:^(NSDictionary *response) {
            [SVProgressHUD dismiss];
            if ([[response objectForKey:kCode] intValue] == 200 && [[response valueForKey:kResponse] isEqualToString:@"Success"])
            {
                NSArray *allUsers = [response objectForKey:kData];
                users = [NSMutableArray arrayWithArray:allUsers];
                if (users.count > 0)
                {
                    _tableViewFriends.hidden = NO;
                    _labelNoData.hidden = YES;
                    [weakSelf updateContent];
                }
                else
                {
                    _tableViewFriends.hidden = YES;
                    _labelNoData.hidden = NO;
                }
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[response valueForKey:kMessage] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
            
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
        }];
    }
    else
    {
        _tableViewFriends.hidden = YES;
        _labelNoData.hidden = NO;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Your location services is off, Please give access to location permission." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)updateContent
{
    [self.tableViewFriends reloadData];
    [_mapView removeAnnotations:_mapView.annotations];
    NSMutableArray <id <MKAnnotation>>*annotations = [NSMutableArray new];
    
    JPSThumbnail *thumbnail = [[JPSThumbnail alloc] init];
    thumbnail.title = [NSString stringWithFormat:@"%@ %@", [LoggedInUser loggedInUser].firstName, [LoggedInUser loggedInUser].lastName];
    NSURL *pinURL = [[NSBundle mainBundle] URLForResource:@"pin" withExtension:@"png"];
    thumbnail.profilePicURL = pinURL.path;
    thumbnail.coordinate = [[LocationManager sharedManager] recentPlacemark].location.coordinate;
    thumbnail.disclosureBlock = ^{ NSLog(@"selected Empire"); };
    [annotations addObject:[JPSThumbnailAnnotation annotationWithThumbnail:thumbnail]];
    
    for (NSDictionary *user in users)
    {
        JPSThumbnail *thumbnail = [[JPSThumbnail alloc] init];
        thumbnail.title = [NSString stringWithFormat:@"%@ %@", [user valueForKey:kFirstName], [user valueForKey:kLastName]];
        
        thumbnail.coordinate = CLLocationCoordinate2DMake([[user valueForKey:kLatitude] doubleValue], [[user valueForKey:kLongitude] doubleValue]);
        thumbnail.disclosureBlock = ^{ NSLog(@"selected Empire"); };
        [annotations addObject:[JPSThumbnailAnnotation annotationWithThumbnail:thumbnail]];
    }
    [_mapView addAnnotations:annotations];
}

#pragma mark MKMapViewDelegate Methods

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation
{
//    MKCoordinateRegion region;
//    MKCoordinateSpan span;
//    span.latitudeDelta = 0.005;
//    span.longitudeDelta = 0.005;
//    CLLocationCoordinate2D location;
//    location.latitude = aUserLocation.coordinate.latitude;
//    location.longitude = aUserLocation.coordinate.longitude;
//    region.span = span;
//    region.center = location;
//    [aMapView setRegion:region animated:YES];
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{    
//    static NSString* AnnotationIdentifier = @"Annotation";
//    MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
//    
//    if (!pinView) {
//        
//        MKAnnotationView *customPinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
//        if (annotation == mapView.userLocation)
//        {
//            customPinView.image = [UIImage imageNamed:@"location.png"];
//        }
//        else{
//            customPinView.image = [UIImage imageNamed:@"location.png"];
//        }
//        customPinView.canShowCallout = NO;
//        return customPinView;
//        
//    }
//    else
//    {
//        pinView.annotation = annotation;
//    }
//    
//    return pinView;
//}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}

#pragma mark UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExploreTableViewCell *cell = [_tableViewFriends dequeueReusableCellWithIdentifier:NSStringFromClass([ExploreTableViewCell class]) forIndexPath:indexPath];
    NSDictionary *user = [users objectAtIndex:indexPath.row];
    [cell setUser:user];
    return cell;
}

@end
