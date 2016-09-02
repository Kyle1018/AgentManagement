//
//  AMRegistRequest.m
//  AgentManagement
//
//  Created by huabin on 16/9/2.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMRegistRequest.h"

@implementation AMRegistRequest

- (instancetype)initWithPhone:(NSString *)phone Password:(NSString*)password Code:(NSString*)code
{
    self = [super init];
    if (self) {
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
     NSLog(@"注册信息：－－－－－－－－－－－%@",dictionary);
    
    return nil;
    //return [[AMIdentifyCode alloc] initWithDictionary:dictionary error:nil];
}


@end
