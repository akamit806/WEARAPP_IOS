//
//  EditProfileViewController.m
//  AppWEAR
//
//  Created by HKM on 15/02/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "EditProfileViewController.h"
#import "NSString+PJR.h"
#import "LoggedInUser.h"

@interface EditProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UITextView *textViewAboutMe;

@end

@implementation EditProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"PROFILE";
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    [self setupProfileData];
}

-(void)setupProfileData
{
    LoggedInUser *user = [LoggedInUser loggedInUser];
    [_textFieldFirstName setText:user.firstName];
    [_textFieldLastName setText:user.lastName];
    [_textFieldEmail setText:user.email];
    [_textFieldPassword setText:user.password];
    if (user.isSocialLogin.boolValue && (user.email == nil || user.email.length == 0))
    {
        [_textFieldEmail setEnabled:YES];
    }
    else
    {
        [_textFieldEmail setEnabled:NO];
    }
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveClicked:(UIButton *)sender
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
        else
        {
            /*
             {
             "access_token":"RRZQCB0N6T5QTKZN",
             "firstname":"kamlesh",
             "mobile":"123456",
             "gender":"male",
             "lastname":"rathore"
             
             }
             */
            __weak typeof (self) weakSelf = self;
            [self.view endEditing:YES];
            [SVProgressHUD showWithStatus:@"Updating Profile..."];
            LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
            NSDictionary *parameters = @{kAccess_Token : loggedInUser.accessToken, kFirstName : _textFieldFirstName.text, kLastName : _textFieldLastName.text, kMobile : loggedInUser.mobile, kGender : loggedInUser.gender, kEmail : _textFieldEmail.text};
            [[WebApiHandler sharedHandler] updateProfileWithParameters:parameters success:^(NSDictionary *response) {
                [SVProgressHUD dismiss];
                if ([[response valueForKey:kResponse] isEqualToString:@"Success"])
                {
                    NSDictionary *data = [response objectForKey:kData];
                    LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
                    loggedInUser.firstName = [data valueForKey:kFirstName];
                    loggedInUser.lastName = [data valueForKey:kLastName];
                    loggedInUser.gender = [data valueForKey:kGender];
                    loggedInUser.mobile = [data valueForKey:kMobile];
                    [LoggedInUser setLoggedInUser:loggedInUser];
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success" message:@"Profile updated successfully." preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }]];
                    [weakSelf presentViewController:alertController animated:YES completion:nil];
                }
                else
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[response valueForKey:kMessage] preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                    [weakSelf presentViewController:alertController animated:YES completion:nil];
                }
            } failure:^(NSError *error) {
                
            }];
        }
    }
}

@end
