//
//  AppDelegate.h
//  AppWEAR
//
//  Created by HKM on 18/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(AppDelegate *)sharedDelegate;

@end

