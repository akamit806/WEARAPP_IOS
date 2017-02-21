//
//  IntermediateSIgnUpViewController.m
//  AppWEAR
//
//  Created by HKM on 24/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "IntermediateSignUpViewController.h"

@interface IntermediateSignUpViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewLogo;
@property (weak, nonatomic) IBOutlet UIButton *buttonFacebook;
@property (weak, nonatomic) IBOutlet UIButton *buttonGoogle;

@end

@implementation IntermediateSignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self setupViews];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)setupViews
{
    [_imageViewLogo layoutIfNeeded];
    [_buttonFacebook layoutIfNeeded];
    [_buttonGoogle layoutIfNeeded];
    
    _imageViewLogo.clipsToBounds = YES;
    [_imageViewLogo.layer setCornerRadius:CGRectGetWidth(_imageViewLogo.bounds)/2];
    
    _buttonFacebook.clipsToBounds = YES;
    [_buttonFacebook.layer setCornerRadius:CGRectGetWidth(_buttonFacebook.bounds)/2];
    
    _buttonGoogle.clipsToBounds = YES;
    [_buttonGoogle.layer setCornerRadius:CGRectGetWidth(_buttonGoogle.bounds)/2];
}


- (IBAction)backButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)signInButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
