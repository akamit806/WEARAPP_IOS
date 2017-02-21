//
//  TrailViewController.m
//  AppWEAR
//
//  Created by HKM on 25/01/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "TrailViewController.h"

@interface TrailViewController ()

@end

@implementation TrailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"TRAIL";
    [self addLeftSideMenuButton];
    UIBarButtonItem *shareBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonClicked)];
    [self.navigationItem setRightBarButtonItem:shareBarButton];
}

-(void)shareButtonClicked
{
    
}

@end
