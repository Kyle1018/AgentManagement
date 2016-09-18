//
//  AMRegisterRequest.m
//  AgentManagement
//
//  Created by Kyle on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMRegisterRequest.h"
#import "AMUser.h"
@implementation AMRegisterRequest


- (instancetype)initWithPhone:(NSString *)phone Password:(NSString*)password Code:(NSString*)code {
    
    self = [super init];
    if (self) {
        DDLogDebug(@"phone:%@",phone);
        DDLogDebug(@"code:%@",code);
        [self.requestParameters safeSetObject:phone forKey:@"phone"];
        [self.requestParameters safeSetObject:password forKey:@"password"];
        [self.requestParameters safeSetObject:code forKey:@"code"];
    }
    return self;
}

- (NSString *)urlPath
{
    return @"apiuser/regist";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
//    
//    DDLogDebug(@"%@",[dictionary[@"resultMessage"]description]);
//    DDLogDebug(@"注册信息：－－－－－－－－－－－%@",dictionary);
//    //
//    return nil;
     return [[AMUser alloc] initWithDictionary:dictionary error:nil];
}

@end
