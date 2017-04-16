//
//  SignUpViewController.m
//  AppWEAR
//
//  Created by HKM on 25/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "SignUpViewController.h"
#import "TextFieldLeftView.h"
#import "NSString+PJR.h"
#import "RESideMenu.h"
#import "TabBarController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "TermsAndConditionsViewController.h"
#import "LoggedInUser.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet TextFieldLeftView *textFieldFirstName;
@property (weak, nonatomic) IBOutlet TextFieldLeftView *textFieldLastName;
@property (weak, nonatomic) IBOutlet TextFieldLeftView *textFieldNickName;
@property (weak, nonatomic) IBOutlet TextFieldLeftView *textFieldEmail;
@property (weak, nonatomic) IBOutlet TextFieldLeftView *textFieldPassword;
@property (weak, nonatomic) IBOutlet TextFieldLeftView *textFieldConfirmPassword;
@property (weak, nonatomic) IBOutlet TextFieldLeftView *textFieldMobile;

@property (weak, nonatomic) IBOutlet UIButton *buttonMale;
@property (weak, nonatomic) IBOutlet UIButton *buttonFemale;
@property (weak, nonatomic) IBOutlet UIButton *buttonTermsNCondition;

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self setupViews];
}

-(void)setupViews
{
    [_textFieldFirstName setLeftImage:[UIImage imageNamed:@"name"]];
    [_textFieldLastName setLeftImage:[UIImage imageNamed:@"name"]];
    [_textFieldNickName setLeftImage:[UIImage imageNamed:@"name"]];
    [_textFieldEmail setLeftImage:[UIImage imageNamed:@"email"]];
    [_textFieldPassword setLeftImage:[UIImage imageNamed:@"password"]];
    [_textFieldConfirmPassword setLeftImage:[UIImage imageNamed:@"password2"]];
    [_textFieldMobile setLeftImage:[UIImage imageNamed:@"mobile"]];
}

- (IBAction)backButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)signInButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)genderButtonClicked:(UIButton *)sender
{
    if (sender.tag == 100)//Male selected
    {
        [_buttonMale setSelected:YES];
        [_buttonFemale setSelected:NO];
    }
    else if (sender.tag == 200)//Female selected
    {
        [_buttonMale setSelected:NO];
        [_buttonFemale setSelected:YES];
    }
}

- (IBAction)termsAndConditionsClicked:(UIButton *)sender
{
    [sender setSelected:!sender.selected];
    if (sender.isSelected)
    {
        [self performSegueWithIdentifier:NSStringFromClass([TermsAndConditionsViewController class]) sender:nil];
    }
}

- (IBAction)continueClicked:(UIButton *)sender
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
        if ([_textFieldFirstName.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please Enter First Name." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldLastName.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please Enter Last Name." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldEmail.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please Enter Email Address." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (![_textFieldEmail.text isValidEmail])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please Enter Valid Email Address." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldPassword.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please Enter Password." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldPassword.text length] < 6)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Password should be atleast 6 characters long." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (![_textFieldPassword.text isEqualToString:_textFieldConfirmPassword.text])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Confirm Password Doesn't Match." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldMobile.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please Eenter Mobile Number." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (![_textFieldMobile.text isVAlidPhoneNumber])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please Enter Valid Phone Number." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (!_buttonTermsNCondition.isSelected)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please accept terms and conditions." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            __weak typeof (self) weakSelf = self;
            [self.view endEditing:YES];
            [SVProgressHUD showWithStatus:@"Signing Up..."];
            NSDictionary *parameters = @{kFirstName : _textFieldFirstName.text, kMiddleName : _textFieldNickName.text, kLastName : _textFieldLastName.text, kGender : (_buttonMale.selected ? kGenderMale : kGenderFemale), kEmail : _textFieldEmail.text, kPassword : _textFieldPassword.text, kCPassword : _textFieldConfirmPassword.text, kMobile :_textFieldMobile.text, kAccessToken : @"3243423", kAccessFrom : @"2", kRegister : @"register"};
            [[WebApiHandler sharedHandler] signUpWithParameters:parameters success:^(NSDictionary *response) {
                [SVProgressHUD dismiss];
                if ([[response objectForKey:kCode] intValue] == 200 && [[response valueForKey:kResponse] isEqualToString:@"Success"])
                {
                    NSDictionary *data = [response objectForKey:kData];
                    NSMutableDictionary *userData = [NSMutableDictionary dictionaryWithDictionary:data];
                    [userData setObject:[parameters valueForKey:kPassword] forKey:kPassword];
                    [userData setObject:[response valueForKey:kAccessToken] forKey:kAccessToken];
                    [userData setObject:[response objectForKey:kId] forKey:kId];
                    [userData setObject:@0 forKey:kIsSocialLogin];
                    LoggedInUser *loggedInUser = [[LoggedInUser alloc] initWithData:userData];
                    [LoggedInUser setLoggedInUser:loggedInUser];
                    
                    [weakSelf navigateToHomeScreen];
                }
                else
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[response valueForKey:kMessage] preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                    [weakSelf presentViewController:alertController animated:YES completion:nil];
                }
                
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }];
        }
    }
    
//    [self navigateToHomeScreen];
    
}

-(void)navigateToHomeScreen
{
    TabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    LeftViewController *leftController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    RightViewController *rightController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
    RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:tabBarController leftMenuViewController:leftController rightMenuViewController:rightController];
    sideMenu.contentViewShadowColor = [UIColor blackColor];
    sideMenu.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenu.contentViewShadowOpacity = 0.6;
    sideMenu.contentViewInPortraitOffsetCenterX = 100;
    sideMenu.contentViewShadowRadius = 12;
    sideMenu.contentViewShadowEnabled = YES;
    sideMenu.scaleContentView = NO;
    sideMenu.scaleMenuView = NO;
    
    [self presentViewController:sideMenu animated:YES completion:nil];
}

@end
