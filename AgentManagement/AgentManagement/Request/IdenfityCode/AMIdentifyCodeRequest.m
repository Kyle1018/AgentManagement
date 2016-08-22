//
//  AMIdentifyCodeRequest.m
//  AgentManagement
//
//  Created by Kyle on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMIdentifyCodeRequest.h"

@implementation AMIdentifyCodeRequest

- (instancetype)initWithPhone:(NSString *)phone
{
    self = [super init];
    if (self) {
        [self.requestParameters safeSetObject:phone forKey:@"phone"];
    }
    return self;
}

- (NSString *)urlPath
{
    return @"sendsms";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    return nil;
}

@end