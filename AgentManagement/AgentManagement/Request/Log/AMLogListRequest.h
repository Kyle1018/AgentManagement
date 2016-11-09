//
//  AMLogListRequest.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMLogListRequest : AMBaseRequest

- (instancetype)initWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;

@end
