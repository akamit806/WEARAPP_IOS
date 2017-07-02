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
FOUNDATION_EXPORT NSString *const kUpdateLocation;
FOUNDATION_EXPORT NSString *const kGetUsersByRadius;
FOUNDATION_EXPORT NSString *const kTrialSave;
FOUNDATION_EXPORT NSString *const kSearchTrial;
FOUNDATION_EXPORT NSString *const kSearchUserTrial;
FOUNDATION_EXPORT NSString *const kGetSetting;
FOUNDATION_EXPORT NSString *const kUpdateSetting;
FOUNDATION_EXPORT NSString *const ktrialDelete;

#pragma -mark API Request Parameters

FOUNDATION_EXPORT NSString *const kFirstName;
FOUNDATION_EXPORT NSString *const kMiddleName;
FOUNDATION_EXPORT NSString *const kLastName;
FOUNDATION_EXPORT NSString *const kGender;
FOUNDATION_EXPORT NSString *const kEmail;
FOUNDATION_EXPORT NSString *const kAboutMe;
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
FOUNDATION_EXPORT NSString *const kLatitude;
FOUNDATION_EXPORT NSString *const kLongitude;
FOUNDATION_EXPORT NSString *const kAddress;
FOUNDATION_EXPORT NSString *const kDistance;
FOUNDATION_EXPORT NSString *const kTrial_Date;
FOUNDATION_EXPORT NSString *const kTrial_Name;
FOUNDATION_EXPORT NSString *const kTrial_Id;
FOUNDATION_EXPORT NSString *const kTrial_Status;
FOUNDATION_EXPORT NSString *const kUser_Id;
FOUNDATION_EXPORT NSString *const kSearch_trial;
FOUNDATION_EXPORT NSString *const kUser_Name;
FOUNDATION_EXPORT NSString *const kTrail_Time;
FOUNDATION_EXPORT NSString *const kIsTrailSelected;
FOUNDATION_EXPORT NSString *const kTrail_Path;

#pragma -mark API Response Parameters

FOUNDATION_EXPORT NSString *const kResponse;
FOUNDATION_EXPORT NSString *const kError;
FOUNDATION_EXPORT NSString *const kCode;
FOUNDATION_EXPORT NSString *const kId;
FOUNDATION_EXPORT NSString *const kMessage;
FOUNDATION_EXPORT NSString *const kData;
FOUNDATION_EXPORT NSString *const kGenderMale;
FOUNDATION_EXPORT NSString *const kGenderFemale;

#pragma -mark Weather API

FOUNDATION_EXPORT NSString *const kWeatherAPIURL;

FOUNDATION_EXPORT NSString *const kWeatherAPISubscriptionKey;
FOUNDATION_EXPORT NSString *const kWeatherLocation;
FOUNDATION_EXPORT NSString *const kWeatherLocationType;
FOUNDATION_EXPORT NSString *const kWeatherUnits;
FOUNDATION_EXPORT NSString *const kWeatherCultureInfo;
FOUNDATION_EXPORT NSString *const kWeatherVerbose;
FOUNDATION_EXPORT NSString *const kWeatherSubscriptionKey;

// Common Messages

FOUNDATION_EXPORT NSString *const kMessageNetworkNotAvailable;

#pragma -mark Other Constants

FOUNDATION_EXPORT NSString *const kLoggedInUser;

#pragma -mark Common Functions

NSDateFormatter *appDateFormatter();
NSDateFormatter *weatherDateFormatter();
