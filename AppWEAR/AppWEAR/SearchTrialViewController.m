//
//  SearchTrialViewController.m
//  AppWEAR
//
//  Created by HKM on 05/03/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "SearchTrialViewController.h"
#import <MapKit/MapKit.h>
#import "TextFieldRightView.h"
#import "Reachability.h"
#import "WebApiHandler.h"
#import "LoggedInUser.h"
#import "NSString+PJR.h"
#import "SVProgressHUD.h"
#import "SearchTrailTableViewCell.h"
#import "JPSThumbnailAnnotation.h"

@interface SearchTrialViewController () <MKMapViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
{
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableViewTrails;
@property (weak, nonatomic) IBOutlet MKMapView *mapViewTrails;
@property (weak, nonatomic) IBOutlet TextFieldRightView *textFieldSearch;
@property (strong, nonatomic) NSMutableArray *searchedTrails;
@property (weak, nonatomic) IBOutlet UILabel *labelNoData;
@property (strong, nonatomic) MKPolyline *polyline;

@end

@implementation SearchTrialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_mapViewTrails setDelegate:self];
    [_textFieldSearch setDelegate:self];
    [_textFieldSearch setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
    [_tableViewTrails setDelegate:self];
    [_tableViewTrails setDataSource:self];
    
    [_labelNoData setHidden:NO];
    [_tableViewTrails setHidden:YES];
    _tableViewTrails.tableFooterView = [UIView new];
    
    [self getUserTrails];
}

-(void)getUserTrails
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:kMessageNetworkNotAvailable preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    else
    {
        __weak typeof (self) weakSelf = self;
        LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
        NSDictionary *parameters = @{kAccess_Token : loggedInUser.accessToken, kUser_Id : loggedInUser.userId};
        [SVProgressHUD showWithStatus:@"Searching..."];
        [[WebApiHandler sharedHandler] searchUserTrailWithParameters:parameters success:^(NSDictionary *response) {
            [SVProgressHUD dismiss];
            if ([[response valueForKey:kResponse] isEqualToString:@"Success"])
            {
                id dataObject = [response objectForKey:kData];
                if(dataObject != [NSNull null])
                {
                    NSArray *tempTrails = [response objectForKey:kData];
                    if (tempTrails.count > 0)
                    {
                        weakSelf.searchedTrails = [NSMutableArray new];
                        for (NSDictionary *trail in tempTrails)
                        {
                            NSMutableDictionary * trailToSave = [NSMutableDictionary dictionaryWithDictionary:trail];
                            [trailToSave setObject:@0 forKey:kIsTrailSelected];
                            [weakSelf.searchedTrails addObject:trailToSave];
                        }
                        
                        NSMutableDictionary *firstTrail = [weakSelf.searchedTrails firstObject];
                        [firstTrail setObject:@1 forKey:kIsTrailSelected];
                        [weakSelf addPolylineForTrail:firstTrail];
                        
                        [_labelNoData setHidden:YES];
                        [weakSelf.tableViewTrails setHidden:NO];
                        [weakSelf.tableViewTrails reloadData];
                    }
                    else
                    {
                        [_labelNoData setHidden:NO];
                        [weakSelf.tableViewTrails setHidden:YES];
                    }
                }
                else
                {
                    [_labelNoData setHidden:NO];
                    [weakSelf.tableViewTrails setHidden:YES];
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
        }];
    }
}

-(void)searchTrails
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:kMessageNetworkNotAvailable preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    else
    {
        __weak typeof (self) weakSelf = self;
        LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
        NSDictionary *parameters = @{kAccess_Token : loggedInUser.accessToken, kUser_Id : loggedInUser.userId, kSearch_trial : _textFieldSearch.text};
        [SVProgressHUD showWithStatus:@"Searching..."];
        [[WebApiHandler sharedHandler] searchTrailWithParameters:parameters success:^(NSDictionary *response) {
            [SVProgressHUD dismiss];
            if ([[response valueForKey:kResponse] isEqualToString:@"Success"])
            {
                [weakSelf.searchedTrails removeAllObjects];
                id dataObject = [response objectForKey:kData];
                if(dataObject != [NSNull null])
                {
                    NSArray *tempTrails = [response objectForKey:kData];
                    if (tempTrails.count > 0)
                    {
                        weakSelf.searchedTrails = [NSMutableArray new];
                        for (NSDictionary *trail in tempTrails)
                        {
                            NSMutableDictionary * trailToSave = [NSMutableDictionary dictionaryWithDictionary:trail];
                            [trailToSave setObject:@0 forKey:kIsTrailSelected];
                            [weakSelf.searchedTrails addObject:trailToSave];
                        }
                        
                        NSMutableDictionary *firstTrail = [weakSelf.searchedTrails firstObject];
                        [firstTrail setObject:@1 forKey:kIsTrailSelected];
                        [weakSelf addPolylineForTrail:firstTrail];
                        
                        [_labelNoData setHidden:YES];
                        [weakSelf.tableViewTrails setHidden:NO];
                        [weakSelf.tableViewTrails reloadData];
                    }
                    else
                    {
                        [_labelNoData setHidden:NO];
                        [weakSelf.tableViewTrails setHidden:YES];
                    }
                }
                else
                {
                    [_labelNoData setHidden:NO];
                    [weakSelf.tableViewTrails setHidden:YES];
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
        }];
    }
}

-(void)addPolylineForTrail:(NSDictionary *)trail
{
    if (self.polyline)
    {
        [_mapViewTrails removeOverlay:self.polyline];
    }
    
    if (_mapViewTrails.annotations.count > 0)
    {
        [_mapViewTrails removeAnnotations:_mapViewTrails.annotations];
    }
    
    NSArray *trailPath = [trail objectForKey:kTrail_Path];
    if (trailPath.count > 0)
    {
        CLLocationCoordinate2D coordinates[trailPath.count];
        
        for (int i = 0; i < trailPath.count; i++)
        {
            NSDictionary *trail = [trailPath objectAtIndex:i];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[trail valueForKey:kLatitude] doubleValue], [[trail valueForKey:kLongitude] doubleValue]);
            if (i == 0 || i == (trailPath.count - 1)) //Start Or End Of Trail, Need to drop Pin
            {
                JPSThumbnail *thumbnail = [[JPSThumbnail alloc] init];
                thumbnail.title = @"";
                NSString *pinImagePath = [[NSBundle mainBundle] pathForResource:@"pin" ofType:@"png"];
                thumbnail.profilePicURL = [NSURL fileURLWithPath:pinImagePath];
                thumbnail.coordinate = coordinate;
                [_mapViewTrails addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:thumbnail]];
            }
            coordinates[i] = coordinate;
        }
        self.polyline = [MKPolyline polylineWithCoordinates:coordinates count:trailPath.count];
        [_mapViewTrails addOverlay:self.polyline];
        [_mapViewTrails setVisibleMapRect:[self.polyline boundingMapRect] edgePadding:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0) animated:YES];
    }
}

#pragma -mark UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length > 0)
    {
        NSString *trimmedString = textField.text.removeWhiteSpacesFromString;
        if (trimmedString.length > 0)
        {
            [self searchTrails];
        }
        textField.text = @"";
    }
    return YES;
}

#pragma mark UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchedTrails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTrailTableViewCell *cell = [_tableViewTrails dequeueReusableCellWithIdentifier:NSStringFromClass([SearchTrailTableViewCell class]) forIndexPath:indexPath];
    NSDictionary *trail = [_searchedTrails objectAtIndex:indexPath.row];
    [cell setTrail:trail];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *trail = [_searchedTrails objectAtIndex:indexPath.row];
    BOOL isTrailSelected = [[trail objectForKey:kIsTrailSelected] boolValue];
    if (!isTrailSelected)
    {
        NSArray *selectedTrails = [_searchedTrails filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K == YES", kIsTrailSelected]];
        if (selectedTrails.count > 0)
        {
            NSMutableDictionary *selectedTrail = [selectedTrails firstObject];
            [selectedTrail setObject:@0 forKey:kIsTrailSelected];
        }
        [trail setObject:@1 forKey:kIsTrailSelected];
        [self addPolylineForTrail:trail];
        [_tableViewTrails reloadData];
    }
}

#pragma -mark MKMapViewDelegate Methods

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
