//
//  AMEPinformationRequest.m
//  AgentManagement
//
//  Created by 郭华滨 on 17/1/18.
//  Copyright © 2017年 KK. All rights reserved.
//

#import "AMEPinformationRequest.h"

@implementation AMEPinformationRequest

- (instancetype)initWithEPInformation:(NSDictionary*)dic {
    self = [super init];
    if (self) {
        [self.requestParameters addEntriesFromDictionary:dic];
    }
    return self;
}


- (NSString *)urlPath
{
    return @"nativeapi/addEP";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    return [[AMBaseModel alloc]initWithDictionary:dictionary error:nil];
}


@end
