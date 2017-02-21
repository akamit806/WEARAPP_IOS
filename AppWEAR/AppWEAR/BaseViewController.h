//
//  BaseViewController.h
//  AppWEAR
//
//  Created by HKM on 18/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+RESideMenu.h"
#import "Reachability.h"
#import "WebApiHandler.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "LoggedInUser.h"

@interface BaseViewController : UIViewController

-(void)addLeftSideMenuButton;//Call to add burger left bar button item.
-(void)leftSideMenuButtonClicked;//Action for left side menu button.

@end
