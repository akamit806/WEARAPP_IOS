//
//  TextFieldLeftView.m
//  AppWEAR
//
//  Created by HKM on 20/12/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "TextFieldLeftView.h"

static const CGFloat kPaddingViewWidth  =   10;
static const CGFloat kFontMultiplier    =   0.35;

@interface TextFieldLeftView ()
{
    UIImageView *leftImageView;
}

@end

@implementation TextFieldLeftView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect rect = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.height);
    [leftImageView setFrame:CGRectMake(0, 0, CGRectGetHeight(self.bounds), CGRectGetHeight(self.bounds))];
    return rect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.size.width - kPaddingViewWidth, bounds.origin.y, kPaddingViewWidth, bounds.size.height);;
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
    
    leftImageView = [UIImageView new];
    [leftImageView setBackgroundColor:[UIColor clearColor]];
    [leftImageView setContentMode:UIViewContentModeCenter];
    [leftView addSubview:leftImageView];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

-(void)setLeftImage:(UIImage *)leftImage
{
    _leftImage = leftImage;
    [leftImageView setImage:_leftImage];
}

@end
