//
//  AMProductAndModelList.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMProductAndModelListRequest.h"

@implementation AMProductAndModelListRequest


- (NSString *)urlPath
{
    return @"apiconfig/model";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    
    
    NSLog(@"%@",dictionary);
    
    return nil;
    //return [[KKBaseModel alloc] initWithDictionary:dictionary error:nil];
}

@end
