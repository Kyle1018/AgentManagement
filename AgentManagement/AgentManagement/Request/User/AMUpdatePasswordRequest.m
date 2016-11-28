//
//  AMUpdatePasswordRequest.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMUpdatePasswordRequest.h"

@implementation AMUpdatePasswordRequest

- (instancetype)initWithCurrentPassword:(NSString *)currentPassword inputPassword:(NSString *)inputPassword confirmPassword:(NSString *)confirmPassword {
    self = [super init];
    if (self) {
        [self.requestParameters safeSetObject:currentPassword forKey:@"current_password"];
        [self.requestParameters safeSetObject:inputPassword forKey:@"new_password"];
        [self.requestParameters safeSetObject:confirmPassword forKey:@"confirm_password"];
    }
    return self;
}

- (NSString *)urlPath {
    return @"apiuser/password";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary {
    return [[AMBaseModel alloc] initWithDictionary:dictionary error:nil];
}

@end
