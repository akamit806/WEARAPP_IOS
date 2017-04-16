//
//  WarningTableViewCell.h
//  AppWEAR
//
//  Created by HKM on 12/04/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WarningTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelAvalanche;
@property (weak, nonatomic) IBOutlet UILabel *labelDistance;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@end
