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


- (instancetype)initWithPhone:(NSString *)phone password:(NSString*)password re_password:(NSString*)re_password agree:(NSString*)agree code:(NSString*)code{
    self = [super init];
    if (self) {
     
        [self.requestParameters safeSetObject:phone forKey:@"phone"];
        [self.requestParameters safeSetObject:password forKey:@"password"];
        [self.requestParameters safeSetObject:password forKey:@"re_password"];
        [self.requestParameters safeSetObject:@"1" forKey:@"agree"];
        [self.requestParameters safeSetObject:code forKey:@"code"];
    }
    return self;
}

- (NSString *)urlPath
{
    return @"nativeapi/register";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{

    return [[AMBaseModel alloc]initWithDictionary:dictionary error:nil];
   // NSLog(@"%@",dictionary);
    //return [[AMUser alloc] initWithDictionary:dictionary error:nil];
}

@end
