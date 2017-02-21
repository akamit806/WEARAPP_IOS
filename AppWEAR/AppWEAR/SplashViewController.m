//
//  ViewController.m
//  AppWEAR
//
//  Created by HKM on 18/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "SplashViewController.h"
#import "IntroductionViewController.h"
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
    [self performSegueWithIdentifier:NSStringFromClass([IntroductionViewController class]) sender:nil];
}

@end
