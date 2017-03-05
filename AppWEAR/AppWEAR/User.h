//
//  User.h
//  AppWEAR
//
//  Created by HKM on 15/02/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

@interface User : NSObject <NSCoding>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *middleName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *userAvatar;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *aboutMe;

-(NSString *)fullName;

-(instancetype)initWithData:(NSDictionary *)data;

@end
