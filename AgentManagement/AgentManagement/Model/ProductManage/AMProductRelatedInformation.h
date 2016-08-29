//
//  AMProductRelatedInformation.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseModel.h"

@interface AMProductRelatedInformation : AMBaseModel

//@property(nonatomic,strong)NSArray *data;

@property(nonatomic,copy)NSString *key;

@property(nonatomic,strong)NSArray *value;

@end
