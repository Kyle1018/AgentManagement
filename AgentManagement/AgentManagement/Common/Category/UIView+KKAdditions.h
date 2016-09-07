//
//  UIView+KKAdditions.h
//  PuRunMedical
//
//  Created by Kyle on 16/6/17.
//  Copyright © 2016年 PuRun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenFrame [UIScreen mainScreen].bounds
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface UIView (KKFrame)

@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property(nonatomic,assign)CGFloat right;

- (void)removeAllSubviews;

@end

@interface UIView (Xib)

+ (instancetype)viewFromXib;

@end
