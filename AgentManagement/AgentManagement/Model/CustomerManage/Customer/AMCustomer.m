//
//  AMCustomer.m
//  AgentManagement
//
//  Created by huabin on 16/9/20.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMCustomer.h"

@implementation AMCustomer

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"cutomer_id",
                                                       }];
}


@end
