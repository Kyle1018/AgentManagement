//
//  UIColor+KKAdditions.m
//  PuRunMedical
//
//  Created by Kyle on 16/6/20.
//  Copyright © 2016年 PuRun. All rights reserved.
//

#import "UIColor+KKAdditions.h"

@implementation UIColor (KKAdditions)

+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha
{
    if (hex.length >= 6) {
        NSString *hexString = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
        CGFloat red = strtoul([[hexString substringWithRange:NSMakeRange(0, 2)] UTF8String], 0, 16);
        CGFloat green = strtoul([[hexString substringWithRange:NSMakeRange(2, 2)] UTF8String], 0, 16);
        CGFloat yellow = strtoul([[hexString substringWithRange:NSMakeRange(4, 2)] UTF8String], 0, 16);
        
        return [UIColor colorWithRed:(red / 255.) green:(green / 255.) blue:(yellow / 255.) alpha:alpha];
    }
    return nil;
}

+ (UIColor *)colorWithHex:(NSString *)hex
{
    return [UIColor colorWithHex:hex alpha:1.];
}

@end
