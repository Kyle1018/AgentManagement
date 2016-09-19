//
//  AMAdministrators.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAdministrators.h"

@implementation AMAdministrators

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"a_id",
                                                       }];
}


@end
