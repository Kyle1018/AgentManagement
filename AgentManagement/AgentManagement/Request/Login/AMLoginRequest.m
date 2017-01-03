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
    return @"nativeapi/queryLogs";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    
    NSLog(@"%@",[dictionary[@"data"]class]);
      NSLog(@"%@",[dictionary[@"data"]allKeys]);
    
    return [[AMUser alloc] initWithDictionary:[[dictionary[@"data"]objectForKey:@"list"]firstObject] error:nil];;
}

@end
