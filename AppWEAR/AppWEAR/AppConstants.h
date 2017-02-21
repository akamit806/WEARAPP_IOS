//
//  AppConstants.h
//  AppWEAR
//
//  Created by HKM on 21/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^RequestCompletionHandler)(NSDictionary *response);
typedef void(^RequestFailureHandler)(NSError *error);

#pragma -mark APIs

FOUNDATION_EXPORT NSString *const kAPIBaseURL;

FOUNDATION_EXPORT NSString *const kSignUp;
FOUNDATION_EXPORT NSString *const kLogin;
FOUNDATION_EXPORT NSString *const kForgotPassword;
FOUNDATION_EXPORT NSString *const kChangePassword;
FOUNDATION_EXPORT NSString *const kUpdateProfile;
FOUNDATION_EXPORT NSString *const kLoginWithSocial;
FOUNDATION_EXPORT NSString *const kUpdateAvatar;
FOUNDATION_EXPORT NSString *const kGetUserDetail;

#pragma -mark API Request Parameters

FOUNDATION_EXPORT NSString *const kFirstName;
FOUNDATION_EXPORT NSString *const kMiddleName;
FOUNDATION_EXPORT NSString *const kLastName;
FOUNDATION_EXPORT NSString *const kGender;
FOUNDATION_EXPORT NSString *const kEmail;
FOUNDATION_EXPORT NSString *const kPassword;
FOUNDATION_EXPORT NSString *const kCPassword;
FOUNDATION_EXPORT NSString *const kMobile;
FOUNDATION_EXPORT NSString *const kAccessToken;
FOUNDATION_EXPORT NSString *const kAccessFrom;
FOUNDATION_EXPORT NSString *const kRegister;
FOUNDATION_EXPORT NSString *const kUsername;
FOUNDATION_EXPORT NSString *const kAccess_Token;
FOUNDATION_EXPORT NSString *const kOld_Password;
FOUNDATION_EXPORT NSString *const kNew_Password;
FOUNDATION_EXPORT NSString *const kConfirm_Password;
FOUNDATION_EXPORT NSString *const kUserAvatar;
FOUNDATION_EXPORT NSString *const kFb_Id;
FOUNDATION_EXPORT NSString *const kSocialLoginType;
FOUNDATION_EXPORT NSString *const kIsSocialLogin;

#pragma -mark API Response Parameters

FOUNDATION_EXPORT NSString *const kResponse;
FOUNDATION_EXPORT NSString *const kError;
FOUNDATION_EXPORT NSString *const kCode;
FOUNDATION_EXPORT NSString *const kId;
FOUNDATION_EXPORT NSString *const kMessage;
FOUNDATION_EXPORT NSString *const kData;
FOUNDATION_EXPORT NSString *const kGenderMale;
FOUNDATION_EXPORT NSString *const kGenderFemale;

// Common Messages

FOUNDATION_EXPORT NSString *const kMessageNetworkNotAvailable;

#pragma -mark Other Constants

FOUNDATION_EXPORT NSString *const kLoggedInUser;

