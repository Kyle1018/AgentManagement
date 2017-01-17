//
//  AMUser.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/4.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseModel.h"

@interface AMUser : AMBaseModel

@property(nonatomic,copy)NSString *user_id;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *src_id;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSString *parent_id;

@property(nonatomic,copy)NSString *extra_info;

@property(nonatomic,copy)NSString*remark;

@property(nonatomic,copy)NSString *op_user;

@property(nonatomic,copy)NSString *username;

@property(nonatomic,copy)NSString* region;

@property(nonatomic,copy)NSString *login_time;

@property(nonatomic,copy)NSString *create_time;

@property(nonatomic,copy)NSString *update_time;

@property(nonatomic,copy)NSString *role_id;

@property(nonatomic,copy)NSString *ep_id;








/*
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString* userid;//

@property(nonatomic,copy)NSString *update_time;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *role_id;

@property(nonatomic,copy)NSString*remark;

@property(nonatomic,copy)NSString* region;//



@property(nonatomic,copy)NSString *parent_id;

@property(nonatomic,copy)NSString *op_user;

@property(nonatomic,copy)NSString *op_remark;

@property(nonatomic,copy)NSString *login_time;

@property(nonatomic,copy)NSString *user_id;

@property(nonatomic,copy)NSString *extra_info;

@property(nonatomic,copy)NSString *ep_id;

@property(nonatomic,copy)NSString *create_time;
*/
/**
 * {
 "create_time" = "2016-12-21 14:09:27";
 "ep_id" = 1000005;
 "extra_info" = "";
 id = 17;
 "login_time" = "1970-01-01 08:00:00";
 "op_remark" = "\U4f01\U4e1a\U6ce8\U518c";
 "op_user" = 13501167925;
 "parent_id" = 0;
 phone = 13501167925;
 region = "";
 remark = "";
 "role_id" = 1;
 status = 0;
 "update_time" = "2016-12-21 14:09:27";
 userid = 0;
 username = 13501167925;
 */
@end
