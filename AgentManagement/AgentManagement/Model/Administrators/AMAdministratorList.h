//
//  AMAdministratorList.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseModel.h"
#import "AMAdministrators.h"

@interface AMAdministratorList : AMBaseModel

@property (nonatomic, strong) NSArray<AMAdministrators> *list;

@end
