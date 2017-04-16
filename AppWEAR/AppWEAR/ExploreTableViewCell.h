//
//  ExploreTableViewCell.h
//  AppWEAR
//
//  Created by HKM on 01/03/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExploreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *buttonProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelLastSeen;
@property (weak, nonatomic) IBOutlet UILabel *labelDistance;
@property (strong, nonatomic) NSDictionary *user;

@end
