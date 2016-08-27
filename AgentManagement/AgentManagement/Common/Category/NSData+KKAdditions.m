//
//  NSData+KKAdditions.m
//  AgentManagement
//
//  Created by Kyle on 16/8/27.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "NSData+KKAdditions.h"

@implementation NSData (KKAdditions)

- (NSDictionary *)convertToDictionary
{
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:nil];
}

@end
