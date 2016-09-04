//
//  AMRegisterRequest.h
//  AgentManagement
//
//  Created by Kyle on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMRegisterRequest : AMBaseRequest


- (instancetype)initWithPhone:(NSString *)phone Password:(NSString*)password Code:(NSString*)code;


@end
