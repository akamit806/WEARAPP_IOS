//
//  IntroductionViewController.m
//  AppWEAR
//
//  Created by HKM on 16/12/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "IntroductionViewController.h"
#import "IntroContentViewController.h"
#import "IntroContent.h"
#import "SignInViewController.h"
#import "AppPageViewController.h"

static const NSUInteger kIntroDataCount = 3;
static const NSUInteger kTimeInterval = 6.0;

@interface IntroductionViewController () <UIPageViewControllerDataSource>
{
    NSMutableArray *introData;
    NSUInteger visibleSelectedIndex;
    NSTimer *timer;
}

@property (nonatomic, strong) AppPageViewController *pageController;

@end

@implementation IntroductionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    introData = [NSMutableArray arrayWithCapacity:kIntroDataCount];
    [self prepareIntroData];

    [self setupPageController];
    [self.view bringSubviewToFront:self.buttonNext];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(scrollPageControl) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}

#pragma -mark Timer Methods

-(void)scrollPageControl
{
    if (visibleSelectedIndex == kIntroDataCount - 1)
    {
        visibleSelectedIndex = -1;
    }
    
    IntroContentViewController *initialViewController = [self contentViewControllerWithContent:[introData objectAtIndex:(++visibleSelectedIndex)]];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

#pragma -mark Page Controller Methods

-(void)setupPageController
{
    [[UIPageControl appearance] setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor:[UIColor greenColor]];
    [[UIPageControl appearance] setBackgroundColor:[UIColor clearColor]];
    self.pageController = (AppPageViewController *)[[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self.pageController.view setBackgroundColor:[UIColor clearColor]];
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    IntroContentViewController *initialViewController = [self contentViewControllerWithContent:[introData objectAtIndex:0]];
    visibleSelectedIndex = 0;
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

- (IntroContentViewController *) contentViewControllerWithContent:(IntroContent *)content
{
    IntroContentViewController *childViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([IntroContentViewController class])];
    childViewController.introContent = content;
    return childViewController;
}

#pragma -mark UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    IntroContentViewController *introController = (IntroContentViewController *)viewController;
    NSUInteger index = [introData indexOfObject:introController.introContent];
    visibleSelectedIndex = index;
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self contentViewControllerWithContent:[introData objectAtIndex:index]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    IntroContentViewController *introController = (IntroContentViewController *)viewController;
    NSUInteger index = [introData indexOfObject:introController.introContent];
    visibleSelectedIndex = index;
    index++;
    
    if (index == kIntroDataCount) {
        return nil;
    }
    
    return [self contentViewControllerWithContent:[introData objectAtIndex:index]];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    // The number of items reflected in the page indicator.
    return kIntroDataCount;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    // The selected item reflected in the page indicator.
    return visibleSelectedIndex;
}

#pragma -mark Button action

- (IBAction)nextClicked:(UIButton *)sender
{
    [self performSegueWithIdentifier:NSStringFromClass([SignInViewController class]) sender:nil];
//    if (visibleSelectedIndex == kIntroDataCount - 1)
//    {
//        [self performSegueWithIdentifier:NSStringFromClass([SignInViewController class]) sender:nil];
//    }
//    else
//    {
//        IntroContentViewController *initialViewController = [self contentViewControllerWithContent:[introData objectAtIndex:(++visibleSelectedIndex)]];
//        NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
//        
//        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
//    }
}

#pragma -mark Data Helper Methods

-(void)prepareIntroData
{
    IntroContent *contentConnect = [[IntroContent alloc] initWithIntroImage:[UIImage imageNamed:@"Intro_Connect"] title:@"CONNECT" detail:@"Experience your best-loved outdoor activity wearing your favorite AppWEAR™ heated garment with the AppWEAR mobile application.  The app lets you take total control of your heating garment. Easily personalize 1 of the 4 presets for the heating level you love and prefer.  The levels are green=25%, blue=50%, orange=75% and red=100%.  Set it and start warming your very own personal climate!"];
    IntroContent *contentExplore = [[IntroContent alloc] initWithIntroImage:[UIImage imageNamed:@"Intro_Explore"] title:@"EXPLORE" detail:@"The AppWEAR™ app uses Google for directions, geocoding and geolocating. The app allows visibility to other AppWEAR app user locations."];
    IntroContent *contentTrail = [[IntroContent alloc] initWithIntroImage:[UIImage imageNamed:@"Intro_Trail"] title:@"TRAIL" detail:@"View trail and route elevation profiles.  See local routes that locals have created.  Automatic trail routing from your location to the area of your choosing.  Lookup region and trail info including routes, photos, videos and more.  View trail status and reports! Always be informed of up-to-date trail conditions.  Submit trail reports and conditions from the app, including taking photos."];
    [introData addObject:contentConnect];
    [introData addObject:contentExplore];
    [introData addObject:contentTrail];
}

@end
