//
//  AMRegister.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/4.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMRegister.h"

@implementation AMRegister

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"user_id": @"id",
                                                       }];
}

@end
