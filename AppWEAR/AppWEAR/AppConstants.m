//
//  AppConstants.m
//  AppWEAR
//
//  Created by HKM on 21/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "AppConstants.h"

#pragma -mark APIs

NSString *const kAPIBaseURL     =       @"http://appwear.intello3.com/index.php/api/index";

NSString *const kSignUp         =       @"/signup/";
NSString *const kLogin          =       @"/login/";
NSString *const kForgotPassword =       @"/forgotpassword/";
NSString *const kChangePassword =       @"/changepassword/";
NSString *const kUpdateProfile  =       @"/updateprofile/";
NSString *const kLoginWithSocial  =       @"/loginwithSocial/";
NSString *const kUpdateAvatar   =       @"/updateavtar/";
NSString *const kGetUserDetail  =       @"/getUserdetail/";

#pragma -mark API Request Parameters

NSString *const kFirstName      =       @"firstname";
NSString *const kMiddleName     =       @"middlename";
NSString *const kLastName       =       @"lastname";
NSString *const kGender         =       @"gender";
NSString *const kEmail          =       @"email";
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

#pragma -mark API Response Parameters

NSString *const kResponse       =       @"response";
NSString *const kError          =       @"error";
NSString *const kCode           =       @"code";
NSString *const kId             =       @"id";
NSString *const kMessage        =       @"message";
NSString *const kData           =       @"data";
NSString *const kGenderMale     =       @"Male";
NSString *const kGenderFemale   =       @"Female";

#pragma -mark Common Messages

NSString *const kMessageNetworkNotAvailable    =   @"Internet connection is not reachable, Please try later.";

#pragma -mark Other Constants

NSString *const kLoggedInUser   =       @"LoggedInUser";
