//
//  TextFieldPadding.m
//  AppWEAR
//
//  Created by HKM on 22/11/16.
//  Copyright © 2016 HKM. All rights reserved.
//

#import "TextFieldPadding.h"

static const CGFloat kPaddingViewWidth  =   20;

@interface TextFieldPadding ()
{
    UIView *bottomSeparatorView;
}

@end

@implementation TextFieldPadding

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x, bounds.origin.y, kPaddingViewWidth, bounds.size.height);
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.size.width - kPaddingViewWidth, bounds.origin.y, kPaddingViewWidth, bounds.size.height);;
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
    
    //Setup bottom line view
    bottomSeparatorView = [UIView new];
    [bottomSeparatorView setBackgroundColor:[UIColor darkGrayColor]];
    [self addSubview:bottomSeparatorView];
    [self setupConstraintForBottomView];
}

-(void)setupConstraintForBottomView
{
    [bottomSeparatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:bottomSeparatorView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:bottomSeparatorView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    [self addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:bottomSeparatorView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    [self addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:bottomSeparatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.0];
    [self addConstraint:constraint];
    
}

-(void)setShowBottomSeparatorLine:(BOOL)showBottomSeparatorLine
{
    _showBottomSeparatorLine = showBottomSeparatorLine;
    [bottomSeparatorView setHidden:!_showBottomSeparatorLine];
}

@end
