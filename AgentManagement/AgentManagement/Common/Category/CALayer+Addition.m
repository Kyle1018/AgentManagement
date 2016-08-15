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

//- (UIColor *)borderColorFromUIColor {
//    return objc_getAssociatedObject(self, @selector(borderColorFromUIColor));
//}
//-(void)setBorderColorFromUIColor:(UIColor *)color
//{
//    objc_setAssociatedObject(self, @selector(borderColorFromUIColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self setBorderColorFromUI borderColorFromUIColor];
//}
//- (void)setBorderColorFromUI:(UIColor *)color
//{
//    self.borderColor = color.CGColor;
//    //    NSLog(@"%@", color);
//}

- (void)setBorderColorFromUIColor:(UIColor *)borderColorFromUIColor {
    
    self.borderColor = borderColorFromUIColor.CGColor;
}

- (UIColor*)borderColorFromUIColor {
    
    return [UIColor colorWithCGColor:(__bridge CGColorRef _Nonnull)(self.borderColorFromUIColor)];
}

@end
