//
//  AMOrder.h
//  AgentManagement
//
//  Created by huabin on 16/9/20.
//  Copyright © 2016年 KK. All rights reserved.
//

/*
 brand = ".bobnonl";
 "buy_time" = "0000-00-00 00:00:00";
 "c_id" = 3;
 cycle = "2\U4e2a\U6708";
 id = 7;
 "install_time" = "0000-00-00 00:00:00";
 pmodel = jvjvbk;
 */

#import "AMBaseModel.h"

@interface AMOrder : AMBaseModel

@property(nonatomic,copy)NSString *brand;

@property(nonatomic,copy)NSString *buy_time;

@property(nonatomic,assign)NSInteger c_id;

@property(nonatomic,copy)NSString *cycle;

@property(nonatomic,assign)NSInteger dingdan_id;

@property(nonatomic,copy)NSString *install_time;

@property(nonatomic,copy)NSString *pmodel;

@end
