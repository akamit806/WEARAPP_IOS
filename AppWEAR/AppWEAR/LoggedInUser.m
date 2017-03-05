//
//  LoggedInUser.m
//  AppWEAR
//
//  Created by HKM on 15/02/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "LoggedInUser.h"

@implementation LoggedInUser

static LoggedInUser *currentUser = nil;

-(instancetype)initWithData:(NSDictionary *)data
{
    self = [super initWithData:data];
    self.password = [data objectForKey:kPassword];
    self.accessToken = [data objectForKey:kAccessToken];
    self.isSocialLogin = [data objectForKey:kIsSocialLogin];
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    self.password = [aDecoder decodeObjectForKey:kPassword];
    self.accessToken = [aDecoder decodeObjectForKey:kAccessToken];
    self.isSocialLogin = [aDecoder decodeObjectForKey:kIsSocialLogin];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.password forKey:kPassword];
    [aCoder encodeObject:self.accessToken forKey:kAccessToken];
    [aCoder encodeObject:self.isSocialLogin forKey:kIsSocialLogin];
}

+(void)setLoggedInUser:(LoggedInUser *)user
{
    if (user)
    {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kLoggedInUser];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoggedInUser];
    }
    
    currentUser = user;
}

+(LoggedInUser *)loggedInUser
{
    return currentUser;
}

+(LoggedInUser *)alreadyLoggedInUser
{
    NSData *archivedUser = [[NSUserDefaults standardUserDefaults] objectForKey:kLoggedInUser];
    LoggedInUser *loggedInUser = [NSKeyedUnarchiver unarchiveObjectWithData:archivedUser];
    currentUser = loggedInUser;
    return loggedInUser;
}

@end
