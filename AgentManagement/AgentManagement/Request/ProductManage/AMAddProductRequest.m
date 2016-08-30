//
//  AMAddProductRequest.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/30.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAddProductRequest.h"

@implementation AMAddProductRequest

- (NSString *)urlPath
{
    return @"apiproduct/add";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    
    NSLog(@"%@",dictionary);
    
    return [[AMBaseModel alloc]initWithDictionary:dictionary error:nil];
    // return [[AMProductAndModel alloc] initWithDictionary:dictionary error:nil];
}

@end
