//
//  AMLoginRequest.m
//  AgentManagement
//
//  Created by Kyle on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMLoginRequest.h"
#import "AMUser.h"
@implementation AMLoginRequest

- (instancetype)initWithAccount:(NSString *)account password:(NSString *)password
{
    self = [super init];
    if (self) {
        [self.requestParameters safeSetObject:account forKey:@"phone"];
        [self.requestParameters safeSetObject:password forKey:@"password"];
    }
    return self;
}

- (NSString *)urlPath
{
    return @"nativeapi/login";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    
    if ([dictionary[@"data"]isKindOfClass:[NSDictionary class]]) {
        
        return  [[AMUser alloc] initWithDictionary:dictionary[@"data"] error:nil];

    }
    else {
        
        return [[AMBaseModel alloc]initWithDictionary:dictionary error:nil];
    }
}

@end
