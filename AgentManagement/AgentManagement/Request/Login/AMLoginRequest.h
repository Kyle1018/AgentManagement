//
//  AMLoginRequest.h
//  AgentManagement
//
//  Created by Kyle on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMLoginRequest : AMBaseRequest

- (instancetype)initWithAccount:(NSString *)account password:(NSString *)password;

@end
