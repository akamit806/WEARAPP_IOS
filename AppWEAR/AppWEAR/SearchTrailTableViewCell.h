//
//  SearchTrailTableViewCell.h
//  AppWEAR
//
//  Created by HKM on 12/03/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTrailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *labelTrailName;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelAvgTime;
@property (weak, nonatomic) IBOutlet UILabel *labelTrailTime;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (strong, nonatomic) NSDictionary *trail;

@end
