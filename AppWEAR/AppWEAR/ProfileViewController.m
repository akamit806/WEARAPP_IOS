//
//  ProfileViewController.m
//  AppWEAR
//
//  Created by HKM on 25/01/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "ProfileViewController.h"
#import "SDWebImageManager.h"
#import "SignInViewController.h"
#import "AppDelegate.h"

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImage *previousProfileImage;
}
@property (weak, nonatomic) IBOutlet UIButton *buttonProfile;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"PROFILE";
    [self addLeftSideMenuButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getUserProfile];
    [self setupProfileData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_buttonProfile layoutIfNeeded];
    [_buttonProfile.layer setMasksToBounds:YES];
    [_buttonProfile.layer setCornerRadius:CGRectGetHeight(_buttonProfile.bounds)/2];
}

-(void)getUserProfile
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
        LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
        NSDictionary *parameters = @{kAccess_Token : loggedInUser.accessToken};
        [[WebApiHandler sharedHandler] getUserProfileWithParameters:parameters success:^(NSDictionary *response) {
            if ([[response valueForKey:kResponse] isEqualToString:@"Success"])
            {
                NSDictionary *data = [response objectForKey:kData];
                LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
                loggedInUser.firstName = [data valueForKey:kFirstName];
                loggedInUser.lastName = [data valueForKey:kLastName];
                loggedInUser.gender = [data valueForKey:kGender];
                loggedInUser.mobile = [data valueForKey:kMobile];
                loggedInUser.userAvatar = [data valueForKey:kUserAvatar];
                if ([data valueForKey:kAboutMe] == [NSNull null])
                {
                    loggedInUser.aboutMe = @"";
                }
                else
                {
                    loggedInUser.aboutMe = [data valueForKey:kAboutMe];
                }
                [LoggedInUser setLoggedInUser:loggedInUser];
                [weakSelf setupProfileData];
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

-(void)setupProfileData
{
    LoggedInUser *user = [LoggedInUser loggedInUser];
    [_labelName setText:[user fullName]];
    if (user.userAvatar.length > 0)
    {
        [_buttonProfile sd_setImageWithURL:[NSURL URLWithString:user.userAvatar] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRefreshCached];
    }
}

- (IBAction)signOutClicked:(UIButton *)sender
{
    [LoggedInUser setLoggedInUser:nil];
    UINavigationController *mainNavigationController = (UINavigationController *)[AppDelegate sharedDelegate].window.rootViewController;
    SignInViewController *signInController = [mainNavigationController.viewControllers objectAtIndex:2];
    [mainNavigationController popToViewController:signInController animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)profileButtonClicked:(UIButton *)sender
{
    __weak typeof (self) weakSelf = self;

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Pick Profile Image From?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openImagePickerWith:@"Camera"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openImagePickerWith:@"Gallery"];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)openImagePickerWith:(NSString *)option
{
    UIImagePickerControllerSourceType sourceType;
    if ([option isEqualToString:@"Camera"])
    {
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if ([option isEqualToString:@"Gallery"])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.sourceType = sourceType;
        imagePickerController.allowsEditing = YES;
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

-(void)performImageEditWithImage:(UIImage *)image
{
    __weak typeof (self) weakSelf = self;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirm" message:@"Are you sure, You want to update your profile pic?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf updateProfileImage:image];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        [weakSelf.buttonProfile setImage:strongSelf->previousProfileImage forState:UIControlStateNormal];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)updateProfileImage:(UIImage *)image
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
        NSData *data = UIImagePNGRepresentation(image);
        NSString *base64StringImage = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        __weak typeof (self) weakSelf = self;
        [self.view endEditing:YES];
        [SVProgressHUD showWithStatus:@"Updating Profile Picture..."];
        LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
        NSDictionary *parameters = @{kAccess_Token : loggedInUser.accessToken, kUserAvatar : base64StringImage};
        [[WebApiHandler sharedHandler] updateAvatarWithParameters:parameters success:^(NSDictionary *response) {
            [SVProgressHUD dismiss];
            if ([[response valueForKey:kResponse] isEqualToString:@"Success"])
            {
                __block LoggedInUser *loggedInUser = [LoggedInUser loggedInUser];
                loggedInUser.userAvatar = [response valueForKey:@"avtar"];
                [LoggedInUser setLoggedInUser:loggedInUser];
                [[[SDWebImageManager sharedManager] imageCache] clearMemory];
                [[[SDWebImageManager sharedManager] imageCache] clearDiskOnCompletion:^{
                    [weakSelf.buttonProfile sd_setImageWithURL:[NSURL URLWithString:loggedInUser.userAvatar] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRefreshCached];
                }];
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success" message:@"Profile pic updated successfully." preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
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

#pragma -mark UIImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    previousProfileImage = [_buttonProfile imageForState:UIControlStateNormal];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    image = [UIImage imageWithData:imageData];
    [_buttonProfile setImage:image forState:UIControlStateNormal];
    [self performSelector:@selector(performImageEditWithImage:) withObject:image afterDelay:1.0];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
