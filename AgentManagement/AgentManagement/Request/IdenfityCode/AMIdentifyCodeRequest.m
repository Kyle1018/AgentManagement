//
//  AMIdentifyCodeRequest.m
//  AgentManagement
//
//  Created by Kyle on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMIdentifyCodeRequest.h"
#import "AMIdentifyCode.h"

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
    return @"nativeapi/sendCode";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    DDLogDebug(@"验证码：－－－－－－－－－－－%@", dictionary);
    return [[AMIdentifyCode alloc] initWithDictionary:dictionary error:nil];
}

@end
