//
//  UIView+KKFrame.m
//  PuRunMedical
//
//  Created by Kyle on 16/6/17.
//  Copyright © 2016年 PuRun. All rights reserved.
//

#import "UIView+KKFrame.h"

@implementation UIView (KKFrame)

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (void)setOriginX:(CGFloat)originX
{
    CGRect changedFrame = self.frame;
    
    changedFrame.origin.x = originX;
    self.frame = changedFrame;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (void)setOriginY:(CGFloat)originY
{
    CGRect changedFrame = self.frame;
    
    changedFrame.origin.y = originY;
    self.frame = changedFrame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    if (width < 0.) {
        width = 0.;
    }
    CGRect changedFrame = self.frame;
    
    changedFrame.size.width = width;
    self.frame = changedFrame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    if (height < 0.) {
        height = 0.;
    }
    CGRect changedFrame = self.frame;
    
    changedFrame.size.height = height;
    self.frame = changedFrame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    
    center.y = centerY;
    self.center = center;
}

@end
