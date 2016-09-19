//
//  AMAdministrators.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/19.
//  Copyright © 2016年 KK. All rights reserved.
//

/*
 "add_time" = 1472984819;
 address = "<null>";
 "an_id" = 21;
 area = "<null>";
 city = "<null>";
 county = "<null>";
 email = "";
 id = 21;
 img = "<null>";
 level = 0;
 nickname = 13245338238;
 password = eabd8ce9404507aa8c22714d3f5eada9;
 pid = 0;
 province = "<null>";
 tphone = "<null>";
 "updated_at" = 0;
 username = 13245338238;
 */

#import "AMBaseModel.h"

@interface AMAdministrators : AMBaseModel

@property(nonatomic,assign)NSInteger add_time;//注册时间

@property(nonatomic,copy)NSString *address;

@property(nonatomic,assign)NSInteger an_id;

@property(nonatomic,copy)NSString *area;//地区

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *county;

@property(nonatomic,copy)NSString *email;

@property(nonatomic,assign)NSInteger a_id;//用户id

@property(nonatomic,copy)NSString *img;

@property(nonatomic,assign)NSInteger level;//管理员级别

@property(nonatomic,copy)NSString *nickname;//用户名

@property(nonatomic,copy)NSString*password;

@property(nonatomic,assign)NSInteger pid;

@property(nonatomic,copy)NSString*province;

@property(nonatomic,copy)NSString*tphone;

@property(nonatomic,assign)NSInteger updated_at;

@property(nonatomic,assign)NSInteger username;//手机号


@end
