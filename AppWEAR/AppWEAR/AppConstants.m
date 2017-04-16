//
//  AppConstants.m
//  AppWEAR
//
//  Created by HKM on 21/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "AppConstants.h"

#pragma -mark APIs

//NSString *const kAPIBaseURL     =       @"http://appwear.intello3.com/index.php/api/index";

NSString *const kAPIBaseURL     =       @"http://appwear.lotzap.com/index.php/api/index";

NSString *const kSignUp         =       @"/signup/";
NSString *const kLogin          =       @"/login/";
NSString *const kForgotPassword =       @"/forgotpassword/";
NSString *const kChangePassword =       @"/changepassword/";
NSString *const kUpdateProfile  =       @"/updateprofile/";
NSString *const kLoginWithSocial  =       @"/loginwithSocial/";
NSString *const kUpdateAvatar   =       @"/updateavtar/";
NSString *const kGetUserDetail  =       @"/getUserdetail/";
NSString *const kUpdateLocation =       @"/updatelocation";
NSString *const kGetUsersByRadius =     @"/getusersbyRadius";
NSString *const kTrialSave        =     @"/trialSave";
NSString *const kSearchTrial      =     @"/searchTrial";
NSString *const kSearchUserTrial  =     @"/searchUserTrial";
NSString *const kGetSetting       =     @"/getsetting";
NSString *const kUpdateSetting    =     @"/updatesetting";

#pragma -mark API Request Parameters

NSString *const kFirstName      =       @"firstname";
NSString *const kMiddleName     =       @"middlename";
NSString *const kLastName       =       @"lastname";
NSString *const kGender         =       @"gender";
NSString *const kEmail          =       @"email";
NSString *const kAboutMe        =       @"about_me";
NSString *const kPassword       =       @"password";
NSString *const kCPassword      =       @"cpassword";
NSString *const kMobile         =       @"mobile";
NSString *const kAccessToken    =       @"accesstoken";
NSString *const kAccessFrom     =       @"accessfrom";
NSString *const kRegister       =       @"register";
NSString *const kUsername       =       @"username";
NSString *const kAccess_Token   =       @"access_token";
NSString *const kOld_Password   =       @"old_password";
NSString *const kNew_Password   =       @"new_password";
NSString *const kConfirm_Password   =       @"confirm_password";
NSString *const kUserAvatar     =       @"useravtar";
NSString *const kFb_Id          =       @"fb_id";
NSString *const kSocialLoginType =      @"socialLoginType";
NSString *const kIsSocialLogin  =       @"isSocialLogin";
NSString *const kLatitude       =       @"latitude";
NSString *const kLongitude      =       @"longitude";
NSString *const kAddress        =       @"address";
NSString *const kDistance       =       @"distance";
NSString *const kTrial_Date     =       @"trial_date";
NSString *const kTrial_Name     =       @"trial_name";
NSString *const kTrial_Id       =       @"trial_id";
NSString *const kTrial_Status   =       @"trial_status";
NSString *const kUser_Id        =       @"user_id";
NSString *const kSearch_trial   =       @"search_trial";
NSString *const kUser_Name      =       @"user_name";
NSString *const kTrail_Time     =       @"trial_time";
NSString *const kIsTrailSelected     =       @"isTrailSelected";
NSString *const kTrail_Path     =       @"trail_path";

#pragma -mark API Response Parameters

NSString *const kResponse       =       @"response";
NSString *const kError          =       @"error";
NSString *const kCode           =       @"code";
NSString *const kId             =       @"id";
NSString *const kMessage        =       @"message";
NSString *const kData           =       @"data";
NSString *const kGenderMale     =       @"male";
NSString *const kGenderFemale   =       @"female";

#pragma -mark Weather API

NSString *const kWeatherAPIURL  =       @"https://earthnetworks.azure-api.net/data/forecasts/v1/daily";

NSString *const kWeatherAPISubscriptionKey = @"71aa68b2ba84461bb02f4c48a3c22c0d";
NSString *const kWeatherLocation = @"location";
NSString *const kWeatherLocationType = @"locationtype";
NSString *const kWeatherUnits = @"units";
NSString *const kWeatherCultureInfo = @"cultureinfo";
NSString *const kWeatherVerbose = @"verbose";
NSString *const kWeatherSubscriptionKey = @"subscription-key";

#pragma -mark Common Messages

NSString *const kMessageNetworkNotAvailable    =   @"Internet connection is not reachable, Please try later.";

#pragma -mark Other Constants

NSString *const kLoggedInUser   =       @"LoggedInUser";

#pragma -mark Common Functions

NSDateFormatter *appDateFormatter()
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-mm-dd HH:MM:SS"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"IST"]];
    });
    return dateFormatter;
}

NSDateFormatter *weatherDateFormatter()
{//2017-04-11T18:00:00
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-mm-ddTHH:MM:SS"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"IST"]];
    });
    return dateFormatter;
}

