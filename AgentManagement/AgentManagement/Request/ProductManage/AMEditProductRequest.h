//
//  AMEditProductRequest.h
//  AgentManagement
//
//  Created by huabin on 16/9/28.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMEditProductRequest : AMBaseRequest

- (instancetype)initWithEditProductInfo:(NSDictionary*)productInfo;

@end
