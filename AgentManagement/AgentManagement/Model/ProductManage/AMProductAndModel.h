//
//  AMProductAndModel.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseModel.h"

@interface AMProductAndModel : AMBaseModel

@property(nonatomic,copy)NSString *brand;

@property(nonatomic,strong)NSMutableArray *pmodel;

@end
