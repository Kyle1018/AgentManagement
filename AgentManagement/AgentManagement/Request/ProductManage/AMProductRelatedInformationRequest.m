//
//  AMProductRelatedInformationRequest.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMProductRelatedInformationRequest.h"

@implementation AMProductRelatedInformationRequest


- (NSString *)urlPath
{
    return @"apiconfig/index";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    
    NSLog(@"%@",dictionary);
    
    return [[AMBaseModel alloc]initWithDictionary:dictionary error:nil];
   // return [[AMProductAndModel alloc] initWithDictionary:dictionary error:nil];
}

@end
