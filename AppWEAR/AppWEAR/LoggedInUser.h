//
//  LoggedInUser.h
//  AppWEAR
//
//  Created by HKM on 15/02/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "User.h"

@interface LoggedInUser : User <NSCoding>

@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSNumber *isSocialLogin;

+(void)setLoggedInUser:(LoggedInUser *)user;
+(LoggedInUser *)loggedInUser;
+(LoggedInUser *)alreadyLoggedInUser;

@end
