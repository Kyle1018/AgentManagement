//
//  UIColor+KKAdditions.h
//  PuRunMedical
//
//  Created by Kyle on 16/6/20.
//  Copyright © 2016年 PuRun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KKAdditions)

+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(NSString *)hex;

@end
