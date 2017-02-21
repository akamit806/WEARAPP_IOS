//
//  IntroContentViewController.h
//  AppWEAR
//
//  Created by HKM on 16/12/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "BaseViewController.h"
#import "IntroContent.h"

@interface IntroContentViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageViewIntro;
@property (weak, nonatomic) IBOutlet UILabel *labelIntroTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelIntroDetail;

@property (strong, nonatomic) IntroContent *introContent;

@end
