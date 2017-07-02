//
//  HomeViewController.m
//  AppWEAR
//
//  Created by HKM on 25/01/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "HomeViewController.h"
#import "DDTemperatureUnitConverter.h"
#import "RightViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonProfilePic;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewHuman;
@property (weak, nonatomic) IBOutlet UILabel *labelLocation;
@property (weak, nonatomic) IBOutlet UILabel *labelLatLong;
@property (weak, nonatomic) IBOutlet UIView *viewTemperature;
@property (weak, nonatomic) IBOutlet UILabel *labelTemperature;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [LocationManager sharedManager];
    self.title = @"APPWEAR";
    [self addLeftSideMenuButton];
    UIBarButtonItem *shareBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonClicked)];
    [self.navigationItem setRightBarButtonItem:shareBarButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdated:) name:kLocationUpdateNotification object:[LocationManager sharedManager]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(temperatureViewTapped:)];
    [self.viewTemperature addGestureRecognizer:tapGesture];
}

-(void)temperatureViewTapped:(UITapGestureRecognizer *)gesture
{
    [self.sideMenuViewController presentRightMenuViewController];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLocationUpdateNotification object:[LocationManager sharedManager]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_buttonProfilePic layoutIfNeeded];
    [_buttonProfilePic.layer setMasksToBounds:YES];
    [_buttonProfilePic.layer setCornerRadius:CGRectGetWidth(_buttonProfilePic.bounds)/2];
}

-(void)setupData
{
    LoggedInUser *user = [LoggedInUser loggedInUser];
    if (user.userAvatar.length > 0)
    {
        [_buttonProfilePic sd_setImageWithURL:[NSURL URLWithString:user.userAvatar] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRefreshCached];
    }
    
    if ([user.gender isEqualToString:kGenderMale])
    {
        [_imageViewHuman setImage:[UIImage imageNamed:@"male_gray"]];
    }
    else if ([user.gender isEqualToString:kGenderFemale])
    {
        [_imageViewHuman setImage:[UIImage imageNamed:@"female_gray"]];
    }
    else
    {
        [_imageViewHuman setImage:[UIImage imageNamed:@"male_gray"]];
    }
}

-(void)shareButtonClicked
{
    UIImage *image = [self getCurrentScreenshot];
    NSArray *items = @[image, @"Shared by AppWear."];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        controller.popoverPresentationController.sourceView = self.view;
        controller.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;
    }
    
    [self presentViewController:controller animated:YES completion:^{
        // executes after the user selects something
    }];
}

- (IBAction)profileClicked:(UIButton *)sender
{
    [self.tabBarController setSelectedIndex:1];
}

#pragma mark LocationUpdate

-(void)locationUpdated:(NSNotification *)notification
{
    CLPlacemark *placemark = [notification.userInfo objectForKey:kLocationPlacemark];
    NSString *location = [NSString stringWithFormat:@"%@, %@", placemark.name, placemark.locality];
    [_labelLocation setText:location];
    NSString *latLong = [NSString stringWithFormat:@"%0.4lf N, %0.4lf W", placemark.location.coordinate.latitude, placemark.location.coordinate.longitude];
    [_labelLatLong setText:latLong];
    
    __weak typeof (self) weakSelf = self;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [weakSelf getWeatherInfo];
    });
}

-(void)getWeatherInfo
{
//    NSString *url = @"https://earthnetworks.azure-api.net/getHourly6DayForecast/data/forecasts/v1/hourly?location=22.7196,75.8577&locationtype=latit udelongitude&units=english&offset=0&metadata=true&verbose=true&subscription-key=71aa68b2ba84461bb02f4c48a3c22c0d";
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@ %@", responseString, error);
//    }] resume];
    
    NSString *location = [NSString stringWithFormat:@"%0.4lf,%0.4lf", [[LocationManager sharedManager] currentLocation].coordinate.latitude, [[LocationManager sharedManager] currentLocation].coordinate.longitude];
    NSDictionary *parameters = @{kWeatherLocation : location, kWeatherLocationType : @"latitudelongitude", kWeatherUnits : @"english", kWeatherCultureInfo : @"en-en", kWeatherVerbose : @1, kWeatherSubscriptionKey : kWeatherAPISubscriptionKey};
    __weak typeof (self) weakSelf = self;
    [[WebApiHandler sharedHandler] getWeatherInfoWithParameters:parameters success:^(NSDictionary *response) {
        NSArray *weathers = [response objectForKey:@"dailyForecastPeriods"];
        [weakSelf setupWeatherDataWithTemperature:weathers];
    } failure:^(NSError *error) {
        
    }];
}

-(void)setupWeatherDataWithTemperature:(NSArray *)temperatures
{
    if (temperatures.count > 0)
    {
        NSDictionary *weather = [temperatures firstObject];
        NSNumber *temperature = [weather objectForKey:@"temperature"];
        DDTemperatureUnitConverter *converter = [DDTemperatureUnitConverter temperatureUnitConverter];
        NSNumber *celciousTemperature = [[DDTemperatureUnitConverter temperatureUnitConverter] convertNumber:temperature fromUnit:DDTemperatureUnitFarenheit toUnit:DDTemperatureUnitCelcius];
        NSAttributedString *attributedString = [converter stringForTemperature:[NSNumber numberWithInt:celciousTemperature.intValue] withTemperatureType:DDTemperatureUnitCelcius];
        [self.labelTemperature setAttributedText:attributedString];
        
        RightViewController *rightController = (RightViewController *)self.sideMenuViewController.rightMenuViewController;
        rightController.temperatures = temperatures;
    }
}

@end
