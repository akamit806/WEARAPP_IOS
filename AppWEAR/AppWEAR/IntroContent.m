//
//  IntroContent.m
//  AppWEAR
//
//  Created by HKM on 18/12/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "IntroContent.h"

@implementation IntroContent

-(instancetype)initWithIntroImage:(UIImage *)image title:(NSString *)title detail:(NSString *)detail
{
    self = [super init];
    self.introImage = image;
    self.introTitle = title;
    self.introDetail = detail;
    
    return self;
}

@end
