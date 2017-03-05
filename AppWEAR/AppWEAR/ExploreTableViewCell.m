//
//  ExploreTableViewCell.m
//  AppWEAR
//
//  Created by Hashim Khan on 01/03/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import "ExploreTableViewCell.h"
#import "AppConstants.h"
#import "UIButton+WebCache.h"

@implementation ExploreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setUser:(NSDictionary *)user
{
    _user = user;
    [_labelName setText:[NSString stringWithFormat:@"%@ %@", [_user valueForKey:kFirstName], [_user valueForKey:kLastName]]];
    [_labelLastSeen setText:@"Last seen at this location, 15 minutes ago"];
    [_labelDistance setText:[NSString stringWithFormat:@"%0.0lf feet from me", [[_user valueForKey:kDistance] doubleValue]]];
    NSURL *url = [NSURL URLWithString:[_user valueForKey:@"avtar"]];
    [_buttonProfilePic sd_setImageWithURL:url forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
