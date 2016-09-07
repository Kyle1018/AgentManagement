//
//  AMAddProductInfo.m
//  AgentManagement
//
//  Created by huabin on 16/9/6.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMProductInfo.h"

@implementation AMProductInfo

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"pd_id",
                                                       }];
}



@end
