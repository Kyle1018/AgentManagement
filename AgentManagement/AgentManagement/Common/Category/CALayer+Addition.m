//
//  CALayer+Addition.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CALayer+Addition.h"
#import <objc/runtime.h>
@implementation CALayer (Addition)

- (void)setBorderColorFromUIColor:(UIColor *)borderColorFromUIColor {
    
    self.borderColor = borderColorFromUIColor.CGColor;
}

- (UIColor*)borderColorFromUIColor {
    
    return [UIColor colorWithCGColor:(__bridge CGColorRef _Nonnull)(self.borderColorFromUIColor)];
}

@end
