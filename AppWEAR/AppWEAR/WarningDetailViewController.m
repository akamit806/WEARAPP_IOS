//
//  WarningDetailViewController.m
//  AppWEAR
//
//  Created by HKM on 17/04/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "WarningDetailViewController.h"
#import <MapKit/MapKit.h>

@interface WarningDetailViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapViewWarning;

@end

@implementation WarningDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    self.title = @"Warning";
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
