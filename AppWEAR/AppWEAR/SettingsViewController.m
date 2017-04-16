//
//  SettingsViewController.m
//  AppWEAR
//
//  Created by HKM on 17/02/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonFerenhite;
@property (weak, nonatomic) IBOutlet UIButton *buttonCelcious;
@property (weak, nonatomic) IBOutlet UIButton *buttonChangePassword;
@property (weak, nonatomic) IBOutlet UISwitch *switchNotification;
@property (weak, nonatomic) IBOutlet UISwitch *switchVisibility;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"SECURITY AND SETTING";
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    [self.navigationItem setRightBarButtonItem:saveButton];
    
    if ([[LoggedInUser loggedInUser].isSocialLogin boolValue])
    {
        [_buttonChangePassword setHidden:YES];
    }
    
    [self getSettings];
}

-(void)save
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:kMessageNetworkNotAvailable preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    else
    {
        __weak typeof (self) weakSelf = self;
        [SVProgressHUD showWithStatus:@"Saving Settings..."];
        LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
        NSDictionary *parameters = @{kAccess_Token : loggedInUser.accessToken, @"notification" : (_switchNotification.isOn ? @"ON" : @"OFF"), @"visibility" : (_switchVisibility.isOn ? @"ON" : @"OFF"), @"temperature_unit" : (_buttonCelcious.isSelected ? @1 : @2)};
        [[WebApiHandler sharedHandler] updateSettingsWithParameters:parameters success:^(NSDictionary *response) {
            [SVProgressHUD dismiss];
            if ([[response valueForKey:kResponse] isEqualToString:@"Success"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Settings updated successfully." preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[response valueForKey:kMessage] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
}

-(void)getSettings
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:kMessageNetworkNotAvailable preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    else
    {
        __weak typeof (self) weakSelf = self;
        [SVProgressHUD showWithStatus:@"Fetching Settings..."];
        LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
        NSDictionary *parameters = @{kAccess_Token : loggedInUser.accessToken, kUser_Id : loggedInUser.userId};
        [[WebApiHandler sharedHandler] getSettingsWithParameters:parameters success:^(NSDictionary *response) {
            [SVProgressHUD dismiss];
            if ([[response valueForKey:kResponse] isEqualToString:@"Success"])
            {
                NSDictionary *data = [response objectForKey:kData];
                [weakSelf setupSettingData:data];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[response valueForKey:kMessage] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
}

-(void)setupSettingData:(NSDictionary *)data
{
    if ([[data valueForKey:@"notification"] isEqualToString:@"ON"])
    {
        _switchNotification.on = YES;
    }
    else
    {
        _switchNotification.on = NO;
    }
    
    if ([[data valueForKey:@"visibility"] isEqualToString:@"ON"])
    {
        _switchVisibility.on = YES;
    }
    else
    {
        _switchVisibility.on = NO;
    }
    
    if ([[data objectForKey:@"temperature_unit"] integerValue] == 1)//Celcius
    {
        [_buttonCelcious setBackgroundColor:[UIColor appColor]];
        [_buttonCelcious setSelected:YES];
        [_buttonFerenhite setBackgroundColor:[UIColor appGrayColor]];
        [_buttonFerenhite setSelected:NO];
    }
    else
    {
        [_buttonCelcious setBackgroundColor:[UIColor appGrayColor]];
        [_buttonCelcious setSelected:NO];
        [_buttonFerenhite setBackgroundColor:[UIColor appColor]];
        [_buttonFerenhite setSelected:YES];
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)celciusClicked:(UIButton *)sender
{
    [_buttonCelcious setBackgroundColor:[UIColor appColor]];
    [_buttonCelcious setSelected:YES];
    [_buttonFerenhite setBackgroundColor:[UIColor appGrayColor]];
    [_buttonFerenhite setSelected:NO];
}

- (IBAction)ferenhiteClicked:(UIButton *)sender
{
    [_buttonCelcious setBackgroundColor:[UIColor appGrayColor]];
    [_buttonCelcious setSelected:NO];
    [_buttonFerenhite setBackgroundColor:[UIColor appColor]];
    [_buttonFerenhite setSelected:YES];
}

@end
