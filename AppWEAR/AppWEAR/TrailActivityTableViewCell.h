//
//  TrailActivityTableViewCell.h
//  AppWEAR
//
//  Created by HKM on 12/03/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrailActivityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTrailDetails;
@property (weak, nonatomic) IBOutlet UILabel *labelTrailLength;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelTrailAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelTemp;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (strong, nonatomic) NSDictionary *trail;

@end
