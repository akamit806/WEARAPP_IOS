//
//  SocialManager.m
//  AppWEAR
//
//  Created by HKM on 11/02/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "SocialManager.h"

NSString *const kSocialManagerUserEmail = @"Email";
NSString *const kSocialManagerUserFirstName = @"FirstName";
NSString *const kSocialManagerUserLastName = @"LastName";
NSString *const kSocialManagerUserGender = @"Gender";
NSString *const kSocialManagerUserId = @"Id";
NSString *const kSocialManagerUserBirthday = @"Birthday";

NSString *const kGoogleClientId = @"171897983450-sken2a2r3mvgk08t153uaqfgaksvivvn.apps.googleusercontent.com";
NSString *const kFacebookAppId = @"fb113634572493180";

@interface SocialManager ()<GIDSignInDelegate, GIDSignInUIDelegate>
{
    SocialManagerLoginHandler loginHandler;
}

@property (nonatomic, strong, readwrite) FBSDKLoginManager *fbsdkLoginManager;

@end

@implementation SocialManager

+(instancetype)sharedManager
{
    static SocialManager *socialManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        socialManager = [[self alloc] init];
    });
    return socialManager;
}

-(instancetype)init
{
    self = [super init];
    _fbsdkLoginManager = [[FBSDKLoginManager alloc] init];
    [GIDSignIn sharedInstance].clientID = kGoogleClientId;
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    [[GIDSignIn sharedInstance] setScopes:[NSArray arrayWithObjects:@"https://www.googleapis.com/auth/plus.login", @"https://www.googleapis.com/auth/plus.me", @"https://www.googleapis.com/auth/userinfo.email", @"https://www.googleapis.com/auth/userinfo.profile", nil]];
    
    return self;
}

-(void)loginWithSocialMedia:(SocialMediaType)type completionHandler:(SocialManagerLoginHandler)handler
{
    if (type == SocialMediaTypeFacebook)
    {
        [_fbsdkLoginManager logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error)
            {
                handler(nil, error);
                return;
            }
            if (result.token)
            {
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, email, birthday, first_name, gender, last_name"}] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    if (error)
                    {
                        handler(nil, error);
                        return;
                    }
                    NSMutableDictionary *userInfo = [NSMutableDictionary new];
                    if ([result objectForKey:@"id"])
                    {
                        [userInfo setObject:[result objectForKey:@"id"] forKey:kSocialManagerUserId];
                    }
                    if ([result objectForKey:@"email"])
                    {
                        [userInfo setObject:[result objectForKey:@"email"] forKey:kSocialManagerUserEmail];
                    }
                    if ([result objectForKey:@"birthday"])
                    {
                        [userInfo setObject:[result objectForKey:@"birthday"] forKey:kSocialManagerUserBirthday];
                    }
                    if ([result objectForKey:@"first_name"])
                    {
                        [userInfo setObject:[result objectForKey:@"first_name"] forKey:kSocialManagerUserFirstName];
                    }
                    if ([result objectForKey:@"last_name"])
                    {
                        [userInfo setObject:[result objectForKey:@"last_name"] forKey:kSocialManagerUserLastName];
                    }
                    if ([result objectForKey:@"gender"])
                    {
                        [userInfo setObject:[result objectForKey:@"gender"] forKey:kSocialManagerUserGender];
                    }
                    
                    handler(userInfo, nil);
                }];
            }
            
            
        }];
    }
    else if (type == SocialMediaTypeGoogle)
    {
        loginHandler = handler;
        [[GIDSignIn sharedInstance] signIn];
    }
}

#pragma -mark GIDSignInDelegate Methods

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    if (error)
    {
        loginHandler(nil, error);
        loginHandler = nil;
        return;
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    [userInfo setObject:user.userID forKey:kSocialManagerUserId];
    [userInfo setObject:user.profile.email forKey:kSocialManagerUserEmail];
    [userInfo setObject:@"" forKey:kSocialManagerUserBirthday];
    [userInfo setObject:user.profile.givenName forKey:kSocialManagerUserFirstName];
    [userInfo setObject:user.profile.familyName forKey:kSocialManagerUserLastName];
    [userInfo setObject:@"" forKey:kSocialManagerUserGender];
    
    loginHandler(userInfo, nil);
    loginHandler = nil;
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    // Perform any operations when the user disconnects from app here.
    // ...
}

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error
{
    
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController
{
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController
{
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
