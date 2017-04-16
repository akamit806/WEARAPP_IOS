//
//  SearchTrailTableViewCell.m
//  AppWEAR
//
//  Created by HKM on 12/03/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "SearchTrailTableViewCell.h"
#import "WebApiHandler.h"

@implementation SearchTrailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTrail:(NSDictionary *)trail
{
    _trail = trail;
    [_labelTrailName setText:[_trail valueForKey:kTrial_Name]];
    [_labelName setText:[_trail valueForKey:kUser_Name]];
    [_labelDate setText:[_trail valueForKey:kTrial_Date]];
    [_labelTrailTime setText:[_trail valueForKey:kTrail_Time]];
    BOOL isTrailSelected = [[_trail objectForKey:kIsTrailSelected] boolValue];
    if (isTrailSelected)
    {
        [_containerView setBackgroundColor:[UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1.0]];
    }
    else
    {
        [_containerView setBackgroundColor:[UIColor whiteColor]];
    }
}

@end
