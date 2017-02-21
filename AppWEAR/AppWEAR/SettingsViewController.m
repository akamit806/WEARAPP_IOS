//
//  SettingsViewController.m
//  AppWEAR
//
//  Created by Hashim Khan on 17/02/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonChangePassword;
@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"SECURITY AND SETTING";
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    
    if ([[LoggedInUser loggedInUser].isSocialLogin boolValue])
    {
        [_buttonChangePassword setHidden:YES];
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
