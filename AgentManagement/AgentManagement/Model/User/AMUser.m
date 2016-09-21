//
//  AMUser.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/4.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMUser.h"

@implementation AMUser


+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"user_id",
                                                       }];
}

@end
