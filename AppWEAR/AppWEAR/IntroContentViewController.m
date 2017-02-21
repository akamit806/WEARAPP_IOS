//
//  IntroContentViewController.m
//  AppWEAR
//
//  Created by HKM on 16/12/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "IntroContentViewController.h"

@interface IntroContentViewController ()

@end

@implementation IntroContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_imageViewIntro setImage:_introContent.introImage];
    [_labelIntroTitle setText:_introContent.introTitle];
    [_labelIntroDetail setText:_introContent.introDetail];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)setIntroContent:(IntroContent *)introContent
{
    _introContent = introContent;
    [_imageViewIntro setImage:_introContent.introImage];
    [_labelIntroTitle setText:_introContent.introTitle];
    [_labelIntroDetail setText:_introContent.introDetail];
}

-(void)dealloc
{
    
}

@end
