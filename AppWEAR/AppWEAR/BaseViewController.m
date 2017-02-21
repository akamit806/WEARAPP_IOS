//
//  BaseViewController.m
//  AppWEAR
//
//  Created by HKM on 18/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "BaseViewController.h"
#import "RESideMenu.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)addLeftSideMenuButton
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger"] style:UIBarButtonItemStylePlain target:self action:@selector(leftSideMenuButtonClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
}

-(void)leftSideMenuButtonClicked
{
    [self.sideMenuViewController presentLeftMenuViewController];
}


@end
