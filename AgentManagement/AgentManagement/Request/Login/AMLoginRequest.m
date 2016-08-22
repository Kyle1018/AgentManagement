//
//  AMLoginRequest.m
//  AgentManagement
//
//  Created by Kyle on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMLoginRequest.h"

@implementation AMLoginRequest

- (instancetype)initWithAccount:(NSString *)account password:(NSString *)password
{
    self = [super init];
    if (self) {
        [self.requestParameters safeSetObject:account forKey:@"username"];
        [self.requestParameters safeSetObject:password forKey:@"password"];
    }
    return self;
}

- (NSString *)urlPath
{
    return @"login";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    return nil;
}

@end
