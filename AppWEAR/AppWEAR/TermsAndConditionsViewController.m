//
//  TermsAndConditionsViewController.m
//  AppWEAR
//
//  Created by HKM on 09/02/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "TermsAndConditionsViewController.h"

@interface TermsAndConditionsViewController ()

@end

@implementation TermsAndConditionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"TERMS & CONDITIONS";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
