//
//  TrailActivityTableViewCell.m
//  AppWEAR
//
//  Created by HKM on 12/03/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "TrailActivityTableViewCell.h"
#import "WebApiHandler.h"

@implementation TrailActivityTableViewCell

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
    [_labelTrailDetails setText:[_trail valueForKey:kTrial_Name]];
    [_labelTime setText:[_trail valueForKey:kTrial_Date]];
}

- (IBAction)deleteClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(trailActivityTableViewCell:didClickedDeleteButton:)])
    {
        [self.delegate trailActivityTableViewCell:self didClickedDeleteButton:sender];
    }
}

@end
