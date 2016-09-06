//
//  AMProductListOrSearchRequest.h
//  AgentManagement
//
//  Created by huabin on 16/9/6.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMProductListOrSearchRequest : AMBaseRequest

- (instancetype)initWithPage:(NSString *)phone Size:(NSString*)size Search:(NSArray*)search;

@end
