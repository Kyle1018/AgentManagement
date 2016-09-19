//
//  AMAdministratorListOrSearchRequest.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMAdministratorListOrSearchRequest : AMBaseRequest

- (instancetype)initWithPage:(NSString *)page Size:(NSString*)size Search:(NSDictionary*)search;

@end
