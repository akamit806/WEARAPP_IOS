//
//  TrailViewController.m
//  AppWEAR
//
//  Created by HKM on 25/01/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "TrailViewController.h"
#import "CAPSPageMenu.h"
#import "SearchTrialViewController.h"
#import "NewTrailViewController.h"
#import "TrailActivityViewController.h"

@interface TrailViewController ()

@property (nonatomic, strong) CAPSPageMenu *pageMenu;
@property (nonatomic, strong) SearchTrialViewController *searchTrialViewController;
@property (nonatomic, strong) NewTrailViewController *startTrialViewController;
@property (nonatomic, strong) TrailActivityViewController *trailActivityViewController;

@end

@implementation TrailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"TRAIL";
    [self addLeftSideMenuButton];
    UIBarButtonItem *shareBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonClicked)];
    [self.navigationItem setRightBarButtonItem:shareBarButton];
    [self setupPageMenuController];
}

-(void)setupPageMenuController
{
    NSMutableArray *controllerArray = [NSMutableArray array];
    _searchTrialViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SearchTrialViewController class])];
    _searchTrialViewController.title = @"Search Trail";
    _startTrialViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([NewTrailViewController class])];
    _startTrialViewController.title = @"New Trail";
    _trailActivityViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([TrailActivityViewController class])];
    _trailActivityViewController.title = @"Trail Activity";
    
    [controllerArray addObject:_searchTrialViewController];
    [controllerArray addObject:_startTrialViewController];
    [controllerArray addObject:_trailActivityViewController];
    
    NSDictionary *parameters = @{CAPSPageMenuOptionMenuItemSeparatorWidth: @(4.3),
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(YES),
                                 CAPSPageMenuOptionMenuItemSeparatorPercentageHeight: @(0.1),
                                 CAPSPageMenuOptionScrollMenuBackgroundColor : [UIColor whiteColor],
                                 CAPSPageMenuOptionSelectionIndicatorColor : [UIColor appColor],
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor : [UIColor lightGrayColor],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor : [UIColor appColor],
                                 CAPSPageMenuOptionMenuHeight : @(44)
                                 };
    
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
    
    [self.view addSubview:_pageMenu.view];
}

-(void)shareButtonClicked
{
    UIImage *image = [self getCurrentScreenshot];
    NSArray *items = @[image, @"Shared by AppWear."];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:^{
        // executes after the user selects something
    }];
}

@end
