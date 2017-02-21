//
//  DynamicFontButton.m
//  AppWEAR
//
//  Created by HKM on 26/12/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "DynamicFontButton.h"

static const CGFloat kFontMultiplier    =   0.35;

@implementation DynamicFontButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel setFont:[UIFont systemFontOfSize:(CGRectGetHeight(self.frame) * kFontMultiplier)]];
}

@end
