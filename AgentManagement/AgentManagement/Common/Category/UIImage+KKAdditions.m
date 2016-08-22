//
//  UIImage+KKAdditions.m
//  PuRunMedical
//
//  Created by Kyle on 16/7/27.
//  Copyright © 2016年 PuRun. All rights reserved.
//

#import "UIImage+KKAdditions.h"

@implementation UIImage (KKAdditions)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    if (!color) {
        return nil;
    }
    CGRect rect = CGRectMake(0., 0., 1., 1.);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage *image = nil;
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
