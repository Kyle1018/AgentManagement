//
//  AMToast.h
//  PuRunMedical
//
//  Created by Kyle on 16/7/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMToast : NSObject

+ (void)showDefaultLoadingOnView:(UIView *)view;
+ (void)showLoadingMessage:(NSString *)message onView:(UIView *)view;
+ (void)showAutoDisappearMessage:(NSString *)message onView:(UIView *)view;

+ (void)dismissOnView:(UIView *)view;
+ (void)dismissOnView:(UIView *)view animate:(BOOL)animate;
+ (void)dismissWithMessage:(NSString *)message onView:(UIView *)view;

@end
