//
//  AMOrder.m
//  AgentManagement
//
//  Created by huabin on 16/9/20.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMOrder.h"

@implementation AMOrder

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"dingdan_id",
                                                       }];
}

@end
