//
//  AMRegistRequest.h
//  AgentManagement
//
//  Created by huabin on 16/9/2.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMRegistRequest : AMBaseRequest

- (instancetype)initWithPhone:(NSString *)phone Password:(NSString*)password Code:(NSString*)code;

@end
