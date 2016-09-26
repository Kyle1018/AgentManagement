//
//  AMDeleteCustomerRequest.h
//  AgentManagement
//
//  Created by huabin on 16/9/21.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMDeleteCustomerRequest : AMBaseRequest

- (instancetype)initWithCustomerID:(NSInteger)c_id;

@end
