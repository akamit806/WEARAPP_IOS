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
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"APPWEAR";
    [self addLeftSideMenuButton];
    UIBarButtonItem *shareBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonClicked)];
    [self.navigationItem setRightBarButtonItem:shareBarButton];
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

@end
