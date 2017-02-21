//
//  SocialManager.h
//  AppWEAR
//
//  Created by HKM on 11/02/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

FOUNDATION_EXPORT NSString *const kSocialManagerUserEmail;
FOUNDATION_EXPORT NSString *const kSocialManagerUserFirstName;
FOUNDATION_EXPORT NSString *const kSocialManagerUserLastName;
FOUNDATION_EXPORT NSString *const kSocialManagerUserGender;
FOUNDATION_EXPORT NSString *const kSocialManagerUserId;
FOUNDATION_EXPORT NSString *const kSocialManagerUserBirthday;
FOUNDATION_EXPORT NSString *const kGoogleClientId;
FOUNDATION_EXPORT NSString *const kFacebookAppId;

typedef NS_ENUM(NSInteger, SocialMediaType)
{
    SocialMediaTypeFacebook,
    SocialMediaTypeGoogle
};

/**
 * Completion handler to be called after login.
 * @Param userInfo Contains values for keys : email, firstname, lastname, gender, id
 */
typedef void(^SocialManagerLoginHandler) (NSDictionary *userInfo, NSError *error);

@interface SocialManager : NSObject

+(instancetype)sharedManager;

@property (nonatomic, strong, readonly) FBSDKLoginManager *fbsdkLoginManager;

-(void)loginWithSocialMedia:(SocialMediaType)type completionHandler:(SocialManagerLoginHandler)handler;

@end
