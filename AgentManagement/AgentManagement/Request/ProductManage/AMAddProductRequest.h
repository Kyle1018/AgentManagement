//
//  AMAddProductRequest.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/30.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"

@interface AMAddProductRequest : AMBaseRequest

- (instancetype)initWithAddProductInfo:(NSDictionary*)productInfo;

@end
