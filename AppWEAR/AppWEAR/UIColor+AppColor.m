//
//  UIColor+AppColor.m
//  AppWEAR
//
//  Created by Hashim Khan on 05/03/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import "UIColor+AppColor.h"

@implementation UIColor (AppColor)

+(UIColor *)appColor
{
    static UIColor *color = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        color = [UIColor colorWithRed:53.0/255.0 green:228.0/255.0 blue:101.0/255.0 alpha:1.0];
    });
    return color;
}

@end
