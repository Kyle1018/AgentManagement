//
//  AMAddCustomerRequest.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/12.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMAddCustomerRequest : AMBaseRequest

- (instancetype)initWithAddCustomerInfo:(NSDictionary*)customerInfo;

@end
