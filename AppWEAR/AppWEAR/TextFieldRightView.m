//
//  TextFieldRightView.m
//  AppWEAR
//
//  Created by HKM on 09/03/17.
//  Copyright © 2017 HKM. All rights reserved.
//

#import "TextFieldRightView.h"

static const CGFloat kPaddingViewWidth  =   10;
static const CGFloat kFontMultiplier    =   0.35;

@interface TextFieldRightView ()
{
    UIImageView *rightImageView;
}

@end

@implementation TextFieldRightView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect rect = CGRectMake(bounds.origin.x, bounds.origin.y, kPaddingViewWidth, bounds.size.height);
    return rect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGRect rect = CGRectMake(bounds.size.width - bounds.size.height, bounds.origin.y, bounds.size.height, bounds.size.height);
    [rightImageView setFrame:CGRectMake(0, 0, CGRectGetHeight(self.bounds), CGRectGetHeight(self.bounds))];
    return rect;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setFont:[UIFont systemFontOfSize:(CGRectGetHeight(self.frame) * kFontMultiplier)]];
}

-(void)setup
{
    //Setup left and right view
    UIView *leftView = [UIView new];
    [leftView setBackgroundColor:[UIColor clearColor]];
    [self setLeftView:leftView];
    
    UIView *rightView = [UIView new];
    [rightView setBackgroundColor:[UIColor clearColor]];
    [self setRightView:rightView];
    
    [self setLeftViewMode:UITextFieldViewModeAlways];
    [self setRightViewMode:UITextFieldViewModeAlways];
    
    rightImageView = [UIImageView new];
    [rightImageView setBackgroundColor:[UIColor clearColor]];
    [rightImageView setContentMode:UIViewContentModeCenter];
    [rightView addSubview:rightImageView];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}

-(void)setRightImage:(UIImage *)rightImage
{
    _rightImage = rightImage;
    [rightImageView setImage:_rightImage];
}

@end
