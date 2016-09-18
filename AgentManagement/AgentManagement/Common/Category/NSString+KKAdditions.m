//
//  NSString+KKAdditions.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/15.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "NSString+KKAdditions.h"

@implementation NSString (KKAdditions)

+(NSString*)timeTransformString:(NSString*)time dateFormatter:(NSDateFormatter*)dateFormatter; {
    
    NSTimeInterval timeInterval=[time doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    DDLogDebug(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

@end
