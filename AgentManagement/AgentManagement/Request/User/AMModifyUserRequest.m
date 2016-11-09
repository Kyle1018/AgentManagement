//
//  AMModifyUserRequest.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMModifyUserRequest.h"

@implementation AMModifyUserRequest

- (instancetype)initWithUser:(AMUser *)user {
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)urlPath {
    return @"";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary {
    return [[AMUser alloc] initWithDictionary:dictionary error:nil];
}

@end
