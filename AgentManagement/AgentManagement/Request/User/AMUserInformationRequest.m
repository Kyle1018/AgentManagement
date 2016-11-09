//
//  AMUserInformationRequest.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/5.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMUserInformationRequest.h"
#import "AMUser.h"
@implementation AMUserInformationRequest


- (NSString *)urlPath
{
    return @"apiuser/info";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    return [[AMUser alloc] initWithDictionary:dictionary error:nil];;
    // return [[AMProductAndModel alloc] initWithDictionary:dictionary error:nil];
}


@end
