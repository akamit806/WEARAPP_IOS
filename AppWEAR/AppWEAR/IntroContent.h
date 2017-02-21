//
//  IntroContent.h
//  AppWEAR
//
//  Created by HKM on 18/12/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IntroContent : NSObject

@property (nonatomic, strong) UIImage *introImage;
@property (nonatomic, strong) NSString *introTitle;
@property (nonatomic, strong) NSString *introDetail;

-(instancetype)initWithIntroImage:(UIImage *)image title:(NSString *)title detail:(NSString *)detail;

@end
