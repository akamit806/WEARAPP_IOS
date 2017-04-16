//
//  RightViewController.m
//  AppWEAR
//
//  Created by HKM on 27/01/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "RightViewController.h"
#import "TemperetureTableViewCell.h"
#import <Social/Social.h>

@interface RightViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewTemperature;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@property (weak, nonatomic) IBOutlet UIButton *buttonSun;
@property (weak, nonatomic) IBOutlet UIButton *buttonMon;
@property (weak, nonatomic) IBOutlet UIButton *buttonTue;
@property (weak, nonatomic) IBOutlet UIButton *buttonWed;
@property (weak, nonatomic) IBOutlet UIButton *buttonThu;
@property (weak, nonatomic) IBOutlet UIButton *buttonFri;
@property (weak, nonatomic) IBOutlet UIButton *buttonSat;

@property (weak, nonatomic) IBOutlet UILabel *labelDate;

@end

@implementation RightViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat leadingValue = (CGRectGetWidth(self.view.bounds)/2-100);
    _leadingConstraint.constant = leadingValue;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    _tableViewTemperature.tableFooterView = [UIView new];
    [_tableViewTemperature setDelegate:self];
    [_tableViewTemperature setDataSource:self];
    [_tableViewTemperature reloadData];
}

-(void)setTemperatures:(NSArray *)temperatures
{
    _temperatures = nil;
    _temperatures = [temperatures copy];
    [self setupData];
}

-(void)setupData
{
    
}

- (IBAction)dayButtonClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
        {
            [_buttonSun setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_buttonSun setBackgroundColor:[UIColor appColor]];
            [_buttonMon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonMon setBackgroundColor:[UIColor whiteColor]];
            [_buttonTue setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonTue setBackgroundColor:[UIColor whiteColor]];
            [_buttonWed setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonWed setBackgroundColor:[UIColor whiteColor]];
            [_buttonThu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonThu setBackgroundColor:[UIColor whiteColor]];
            [_buttonFri setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonFri setBackgroundColor:[UIColor whiteColor]];
            [_buttonSat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonSat setBackgroundColor:[UIColor whiteColor]];
        }
            break;
        case 200:
        {
            [_buttonSun setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonSun setBackgroundColor:[UIColor whiteColor]];
            [_buttonMon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_buttonMon setBackgroundColor:[UIColor appColor]];
            [_buttonTue setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonTue setBackgroundColor:[UIColor whiteColor]];
            [_buttonWed setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonWed setBackgroundColor:[UIColor whiteColor]];
            [_buttonThu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonThu setBackgroundColor:[UIColor whiteColor]];
            [_buttonFri setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonFri setBackgroundColor:[UIColor whiteColor]];
            [_buttonSat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonSat setBackgroundColor:[UIColor whiteColor]];
        }
            break;
        case 300:
        {
            [_buttonSun setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonSun setBackgroundColor:[UIColor whiteColor]];
            [_buttonMon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonMon setBackgroundColor:[UIColor whiteColor]];
            [_buttonTue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_buttonTue setBackgroundColor:[UIColor appColor]];
            [_buttonWed setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonWed setBackgroundColor:[UIColor whiteColor]];
            [_buttonThu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonThu setBackgroundColor:[UIColor whiteColor]];
            [_buttonFri setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonFri setBackgroundColor:[UIColor whiteColor]];
            [_buttonSat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonSat setBackgroundColor:[UIColor whiteColor]];
        }
            break;
        case 400:
        {
            [_buttonSun setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonSun setBackgroundColor:[UIColor whiteColor]];
            [_buttonMon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonMon setBackgroundColor:[UIColor whiteColor]];
            [_buttonTue setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonTue setBackgroundColor:[UIColor whiteColor]];
            [_buttonWed setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_buttonWed setBackgroundColor:[UIColor appColor]];
            [_buttonThu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonThu setBackgroundColor:[UIColor whiteColor]];
            [_buttonFri setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonFri setBackgroundColor:[UIColor whiteColor]];
            [_buttonSat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonSat setBackgroundColor:[UIColor whiteColor]];
        }
            break;
        case 500:
        {
            [_buttonSun setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonSun setBackgroundColor:[UIColor whiteColor]];
            [_buttonMon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonMon setBackgroundColor:[UIColor whiteColor]];
            [_buttonTue setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonTue setBackgroundColor:[UIColor whiteColor]];
            [_buttonWed setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonWed setBackgroundColor:[UIColor whiteColor]];
            [_buttonThu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_buttonThu setBackgroundColor:[UIColor appColor]];
            [_buttonFri setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonFri setBackgroundColor:[UIColor whiteColor]];
            [_buttonSat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonSat setBackgroundColor:[UIColor whiteColor]];
        }
            break;
        case 600:
        {
            [_buttonSun setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonSun setBackgroundColor:[UIColor whiteColor]];
            [_buttonMon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonMon setBackgroundColor:[UIColor whiteColor]];
            [_buttonTue setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonTue setBackgroundColor:[UIColor whiteColor]];
            [_buttonWed setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonWed setBackgroundColor:[UIColor whiteColor]];
            [_buttonThu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonThu setBackgroundColor:[UIColor whiteColor]];
            [_buttonFri setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_buttonFri setBackgroundColor:[UIColor appColor]];
            [_buttonSat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonSat setBackgroundColor:[UIColor whiteColor]];
        }
            break;
        case 700:
        {
            [_buttonSun setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonSun setBackgroundColor:[UIColor whiteColor]];
            [_buttonMon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonMon setBackgroundColor:[UIColor whiteColor]];
            [_buttonTue setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonTue setBackgroundColor:[UIColor whiteColor]];
            [_buttonWed setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonWed setBackgroundColor:[UIColor whiteColor]];
            [_buttonThu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonThu setBackgroundColor:[UIColor whiteColor]];
            [_buttonFri setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonFri setBackgroundColor:[UIColor whiteColor]];
            [_buttonSat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_buttonSat setBackgroundColor:[UIColor appColor]];
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)facebookClicked:(UIButton *)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [mySLComposerSheet setInitialText:@"Temperature details!"];
        
        [mySLComposerSheet addImage:[self getCurrentScreenshot]];
        
        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                    
                default:
                    break;
            }
        }];
        
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Your Facebook credentials are not setup in Settings, Please configure Facebook in Settings." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)twitterClicked:(UIButton *)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [mySLComposerSheet setInitialText:@"Temperature details!"];
        
        [mySLComposerSheet addImage:[self getCurrentScreenshot]];
        
        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                    
                default:
                    break;
            }
        }];
        
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Your Twitter credentials are not setup in Settings, Please configure Twitter in Settings." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

//TemperetureTableViewCell
#pragma -mark UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TemperetureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TemperetureTableViewCell class]) forIndexPath:indexPath];
    return cell;
}

@end
