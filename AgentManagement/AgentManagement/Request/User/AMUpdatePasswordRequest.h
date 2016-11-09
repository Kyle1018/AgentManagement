//
//  AMUpdatePasswordRequest.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMUpdatePasswordRequest : AMBaseRequest

- (instancetype)initWithCurrentPassword:(NSString *)currentPassword inputPassword:(NSString *)inputPassword confirmPassword:(NSString *)confirmPassword;

@end
