//
//  NSString+KKAdditions.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/15.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KKAdditions)

+(NSString*)timeTransformString:(NSString*)time dateFormatter:(NSDateFormatter*)dateFormatter;

+ (NSString*)getDateStr:(NSDate*)date;
@end
