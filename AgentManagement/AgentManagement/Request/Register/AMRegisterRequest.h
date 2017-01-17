//
//  AMRegisterRequest.h
//  AgentManagement
//
//  Created by Kyle on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMRegisterRequest : AMBaseRequest


- (instancetype)initWithPhone:(NSString *)phone password:(NSString*)password re_password:(NSString*)re_password agree:(NSString*)agree code:(NSString*)code;


@end
