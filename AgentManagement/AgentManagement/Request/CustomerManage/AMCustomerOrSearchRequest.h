//
//  AMCustomerOrSearchRequest.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/12.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMCustomerOrSearchRequest : AMBaseRequest

- (instancetype)initWithPage:(NSInteger)page Size:(NSInteger)size Search:(NSDictionary*)search;

@end
