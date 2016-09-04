//
//  AMRegisterRequest.m
//  AgentManagement
//
//  Created by Kyle on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMRegisterRequest.h"
#import "AMRegister.h"
@implementation AMRegisterRequest


- (instancetype)initWithPhone:(NSString *)phone Password:(NSString*)password Code:(NSString*)code {
    
    self = [super init];
    if (self) {
        NSLog(@"phone:%@",phone);
        NSLog(@"code:%@",code);
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
//    NSLog(@"%@",[dictionary[@"resultMessage"]description]);
//    NSLog(@"注册信息：－－－－－－－－－－－%@",dictionary);
//    //
//    return nil;
     return [[AMRegister alloc] initWithDictionary:dictionary error:nil];
}

@end
