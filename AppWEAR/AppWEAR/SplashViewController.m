//
//  ViewController.m
//  AppWEAR
//
//  Created by HKM on 18/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "SplashViewController.h"
#import "IntroductionViewController.h"
#import "TabBarController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "SignInViewController.h"
#import "RESideMenu.h"
#import <CoreText/CoreText.h>

@interface SplashViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelDescription;

@end

@implementation SplashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(navigateToSignInControler) withObject:nil afterDelay:3.0];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"App-driven Comfort ClothingTM"];
    [string addAttribute:(NSString *)kCTSuperscriptAttributeName value:@1 range:NSMakeRange(27, 2)];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30.0] range:NSMakeRange(0, 27)];
        [string addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:30] range:NSMakeRange(4, 6)];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19.0] range:NSMakeRange(27, 2)];
    }
    else
    {
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:21.0] range:NSMakeRange(0, 27)];
        [string addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:21.0] range:NSMakeRange(4, 6)];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0] range:NSMakeRange(27, 2)];
    }
    
    [_labelDescription setAttributedText:string];
}

-(void)navigateToSignInControler
{
    if ([LoggedInUser alreadyLoggedInUser])
    {
        [self navigateToHomeScreen];
    }
    else
    {
        [self performSegueWithIdentifier:NSStringFromClass([IntroductionViewController class]) sender:nil];
    }
}

-(void)navigateToHomeScreen
{
    TabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    LeftViewController *leftController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    RightViewController *rightController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
    RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:tabBarController leftMenuViewController:leftController rightMenuViewController:rightController];
    sideMenu.contentViewShadowColor = [UIColor blackColor];
    sideMenu.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenu.contentViewShadowOpacity = 0.6;
    sideMenu.contentViewInPortraitOffsetCenterX = 100;
    sideMenu.contentViewShadowRadius = 12;
    sideMenu.contentViewShadowEnabled = YES;
    sideMenu.scaleContentView = NO;
    sideMenu.scaleMenuView = NO;
    
    __weak typeof (self) weakSelf = self;
    [self presentViewController:sideMenu animated:YES completion:^{
        [weakSelf performSelector:@selector(pushViewControllers) withObject:nil afterDelay:1.0];
    }];
}

-(void)pushViewControllers
{
    IntroductionViewController *introController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([IntroductionViewController class])];
    [self.navigationController pushViewController:introController animated:NO];
    
    SignInViewController *signInController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SignInViewController class])];
    [self.navigationController pushViewController:signInController animated:NO];
}

@end
