//
//  SignInViewController.m
//  AppWEAR
//
//  Created by HKM on 18/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "SignInViewController.h"
#import "TextFieldLeftView.h"
#import "NSString+PJR.h"
#import "RESideMenu.h"
#import "TabBarController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "SocialManager.h"
#import "LoggedInUser.h"

@interface SignInViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewLogo;
@property (weak, nonatomic) IBOutlet UIButton *buttonFacebook;
@property (weak, nonatomic) IBOutlet UIButton *buttonGoogle;
@property (weak, nonatomic) IBOutlet TextFieldLeftView *textFieldEmail;
@property (weak, nonatomic) IBOutlet TextFieldLeftView *textFieldPassword;

@end

@implementation SignInViewController

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
    [_textFieldEmail setLeftImage:[UIImage imageNamed:@"user"]];
    [_textFieldPassword setLeftImage:[UIImage imageNamed:@"password2"]];
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
        if ([_textFieldEmail.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter email address." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (![_textFieldEmail.text isValidEmail])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter valid email address." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldPassword.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter password." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldPassword.text length] < 6)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Password should be atleast 6 characters long." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            __weak typeof (self) weakSelf = self;
            [self.view endEditing:YES];
            [SVProgressHUD showWithStatus:@"Signing In..."];
            NSDictionary *parameters = @{kEmail : _textFieldEmail.text, kPassword : _textFieldPassword.text};
            [[WebApiHandler sharedHandler] loginWithParameters:parameters success:^(NSDictionary *response) {
                [SVProgressHUD dismiss];
                NSLog(@"%@", response);
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
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"User Doesn't Exist! Please try with valid UserName and Password" preferredStyle:UIAlertControllerStyleAlert];
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

- (IBAction)facebookClicked:(UIButton *)sender
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:kMessageNetworkNotAvailable preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    __weak typeof (self) weakSelf = self;
    [self.view endEditing:YES];
    [[SocialManager sharedManager] loginWithSocialMedia:SocialMediaTypeFacebook completionHandler:^(NSDictionary *userInfo, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error)
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
                return;
            }
            else
            {
                [weakSelf performLoginWithSocialMedia:SocialMediaTypeFacebook withParameters:userInfo];
            }
            NSLog(@"User Info = %@", userInfo);
        });
    }];
}

- (IBAction)googleClicked:(UIButton *)sender
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:kMessageNetworkNotAvailable preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    __weak typeof (self) weakSelf = self;
    [self.view endEditing:YES];
    [[SocialManager sharedManager] loginWithSocialMedia:SocialMediaTypeGoogle completionHandler:^(NSDictionary *userInfo, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error)
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
                return;
            }
            else
            {
                __block NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:userInfo];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"We didn't found your gender from Google, but to use AppWEAR properly, you need to tell us your gender. What's your gender:" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Male" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [info setValue:@"male" forKey:kSocialManagerUserGender];
                    [weakSelf performLoginWithSocialMedia:SocialMediaTypeGoogle withParameters:info];
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Female" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [info setValue:@"female" forKey:kSocialManagerUserGender];
                    [weakSelf performLoginWithSocialMedia:SocialMediaTypeGoogle withParameters:info];
                }]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
            NSLog(@"User Info = %@", userInfo);
        });
    }];
}

-(void)performLoginWithSocialMedia:(SocialMediaType)mediaType withParameters:(NSDictionary *)parameters
{
    /*
     {
     "email":"",
     "fb_id":"71171156",
     "socialLoginType":"Facebook",
     "firstname":"kam",
     "gender":"male",
     "lastname":"rr"
     
     }
     */
    NSString *socialLoginType = nil;
    if (mediaType == SocialMediaTypeFacebook)
    {
        socialLoginType = @"Facebook";
    }
    else
    {
        socialLoginType = @"Google";
    }
    __weak typeof (self) weakSelf = self;
    [self.view endEditing:YES];
    [SVProgressHUD showWithStatus:@"Signing In..."];
    NSDictionary *requestParameters = @{kEmail : [parameters valueForKey:kSocialManagerUserEmail], kFb_Id : [parameters valueForKey:kSocialManagerUserId], kSocialLoginType : socialLoginType, kFirstName : [parameters valueForKey:kSocialManagerUserFirstName], kGender : [parameters valueForKey:kSocialManagerUserGender], kLastName : [parameters valueForKey:kSocialManagerUserLastName]};
    [[WebApiHandler sharedHandler] loginUsingSocialWithParameters:requestParameters success:^(NSDictionary *response) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", response);
        if ([[response objectForKey:kCode] intValue] == 200 && [[response valueForKey:kResponse] isEqualToString:@"Success"])
        {
            NSDictionary *data = [response objectForKey:kData];
            NSMutableDictionary *userData = [NSMutableDictionary dictionaryWithDictionary:data];
            [userData setObject:@"" forKey:kPassword];
            [userData setObject:[response valueForKey:kAccessToken] forKey:kAccessToken];
            [userData setObject:[response objectForKey:kId] forKey:kId];
            [userData setObject:@1 forKey:kIsSocialLogin];
            LoggedInUser *loggedInUser = [[LoggedInUser alloc] initWithData:userData];
            [LoggedInUser setLoggedInUser:loggedInUser];
            
            [weakSelf navigateToHomeScreen];
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"User Doesn't Exist! Please try with valid UserName and Password" preferredStyle:UIAlertControllerStyleAlert];
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

-(void)navigateToHomeScreen
{
    TabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    LeftViewController *leftController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:tabBarController leftMenuViewController:leftController rightMenuViewController:nil];
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
