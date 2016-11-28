//
//  PhoneRegisterStateRequest.h
//  AgentManagement
//
//  Created by huabin on 16/10/20.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface PhoneRegisterStateRequest : AMBaseRequest

- (instancetype)initWithPhone:(NSString *)phone;

@end
