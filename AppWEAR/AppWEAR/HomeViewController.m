//
//  HomeViewController.m
//  AppWEAR
//
//  Created by HKM on 25/01/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonProfilePic;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewHuman;
@property (weak, nonatomic) IBOutlet UILabel *labelLocation;
@property (weak, nonatomic) IBOutlet UILabel *labelLatLong;
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
}

@end
