//
//  AMModifySalespersonRequest.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMModifySalespersonRequest : AMBaseRequest

- (instancetype)initWithSalespersonID:(NSString *)salespersonID nickname:(NSString *)nickname phone:(NSString *)phone area:(NSString *)area;

@end
