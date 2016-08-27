//
//  NSDictionary+KKAdditions.m
//  AgentManagement
//
//  Created by Kyle on 16/8/27.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "NSDictionary+KKAdditions.h"

@implementation NSDictionary (KKAdditions)

- (NSData *)convertToData
{
    return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
}

@end
