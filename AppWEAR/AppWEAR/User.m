//
//  User.m
//  AppWEAR
//
//  Created by HKM on 15/02/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "User.h"

@interface User ()

@end

@implementation User

-(instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    self.firstName = [data valueForKey:kFirstName];
    self.lastName = [data valueForKey:kLastName];
    self.middleName = [data valueForKey:kMiddleName];
    self.email = [data valueForKey:kEmail];
    self.mobile = [data valueForKey:kMobile];
    self.gender = [data valueForKey:kGender];
    self.userAvatar = [data valueForKey:kUserAvatar];
    self.userId = [data objectForKey:kId];
    self.aboutMe = [data objectForKey:kAboutMe];
    
    return self;
}

-(NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.firstName = [aDecoder decodeObjectForKey:kFirstName];
    self.lastName = [aDecoder decodeObjectForKey:kLastName];
    self.middleName = [aDecoder decodeObjectForKey:kMiddleName];
    self.email = [aDecoder decodeObjectForKey:kEmail];
    self.mobile = [aDecoder decodeObjectForKey:kMobile];
    self.gender = [aDecoder decodeObjectForKey:kGender];
    self.userAvatar = [aDecoder decodeObjectForKey:kUserAvatar];
    self.userId = [aDecoder decodeObjectForKey:kId];
    self.aboutMe = [aDecoder decodeObjectForKey:kAboutMe];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.firstName forKey:kFirstName];
    [aCoder encodeObject:self.lastName forKey:kLastName];
    [aCoder encodeObject:self.middleName forKey:kMiddleName];
    [aCoder encodeObject:self.email forKey:kEmail];
    [aCoder encodeObject:self.mobile forKey:kMobile];
    [aCoder encodeObject:self.gender forKey:kGender];
    [aCoder encodeObject:self.userAvatar forKey:kUserAvatar];
    [aCoder encodeObject:self.userId forKey:kId];
    [aCoder encodeObject:self.aboutMe forKey:kAboutMe];
}

@end
