//
//  AMAdministratorListRequest.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMAdministratorListRequest : AMBaseRequest

- (instancetype)initWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize name:(NSString *)name phone:(NSString *)phone area:(NSString *)area;

@end
