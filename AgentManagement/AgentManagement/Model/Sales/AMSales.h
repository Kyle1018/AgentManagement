//
//  AMSales.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/19.
//  Copyright © 2016年 KK. All rights reserved.
//

/*
 销售员
 
 "add_time" = 0;
 "an_id" = 1;
 area = "\U897f\U5357";
 id = 8;
 level = 0;
 name = "\U989d\U54df\U54df";
 phone = 14643464642;
 "u_id" = 1;
 */

#import "AMBaseModel.h"

@interface AMSales : AMBaseModel

@property(nonatomic,assign)NSInteger add_time;//添加时间

@property(nonatomic,assign)NSInteger an_id;

@property(nonatomic,copy)NSString *area;//所属地区

@property(nonatomic,assign)NSInteger s_id;//ID

@property(nonatomic,assign)NSInteger level;//销售员级别

@property(nonatomic,copy)NSString *name;//销售员姓名

@property(nonatomic,copy)NSString* phone;//手机号码

@property(nonatomic,assign)NSInteger u_id;
@end
