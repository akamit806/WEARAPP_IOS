//
//  ExploreTableViewCell.h
//  AppWEAR
//
//  Created by Hashim Khan on 01/03/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExploreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *buttonProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelLastSeen;
@property (weak, nonatomic) IBOutlet UILabel *labelDistance;
@property (strong, nonatomic) NSDictionary *user;

@end
