//
//  ChangePasswordViewController.m
//  AppWEAR
//
//  Created by Hashim Khan on 17/02/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "TextFieldLeftView.h"
#import "NSString+PJR.h"
#import "LoggedInUser.h"

@interface ChangePasswordViewController ()

@property (weak, nonatomic) IBOutlet TextFieldLeftView *textFieldOldPassword;
@property (weak, nonatomic) IBOutlet TextFieldLeftView *textFieldNewPassword;
@property (weak, nonatomic) IBOutlet TextFieldLeftView *textFieldConfirmPassword;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"CHANGE PASSWORD";
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    [_textFieldOldPassword setLeftImage:[UIImage imageNamed:@"password"]];
    [_textFieldNewPassword setLeftImage:[UIImage imageNamed:@"password"]];
    [_textFieldConfirmPassword setLeftImage:[UIImage imageNamed:@"password2"]];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneClicked:(UIButton *)sender
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
        if ([_textFieldOldPassword.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please Enter Old Password." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldOldPassword.text length] < 6)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Old Password should be atleast 6 characters long." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldNewPassword.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please Enter New Password." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldNewPassword.text length] < 6)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"New Password should be atleast 6 characters long." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (![_textFieldNewPassword.text isEqualToString:_textFieldConfirmPassword.text])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Confirm Password Doesn't Match." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            __weak typeof (self) weakSelf = self;
            [self.view endEditing:YES];
            [SVProgressHUD showWithStatus:@"Changing Password..."];
            LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
            NSDictionary *parameters = @{kAccess_Token : loggedInUser.accessToken, kOld_Password : _textFieldOldPassword.text, kNew_Password : _textFieldNewPassword.text, kConfirm_Password : _textFieldConfirmPassword.text};
            [[WebApiHandler sharedHandler] changePasswordWithParameters:parameters success:^(NSDictionary *response) {
                [SVProgressHUD dismiss];
                if ([[response valueForKey:kResponse] isEqualToString:@"Success"])
                {
                    LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
                    loggedInUser.password = [parameters valueForKey:kNew_Password];
                    [LoggedInUser setLoggedInUser:loggedInUser];
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success" message:@"Password changed successfully. Please relogin to continue." preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        UINavigationController *navigationController = (UINavigationController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
                        UIViewController *viewController = [navigationController.viewControllers objectAtIndex:2];
                        [navigationController popToViewController:viewController animated:NO];
                        [navigationController dismissViewControllerAnimated:YES completion:nil];
                    }]];
                    [weakSelf presentViewController:alertController animated:YES completion:nil];
                }
                else
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[response valueForKey:kError] preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                    [weakSelf presentViewController:alertController animated:YES completion:nil];
                }
            } failure:^(NSError *error) {
                
            }];
        }
    }
}

@end
