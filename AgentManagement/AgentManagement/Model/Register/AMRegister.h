//
//  AMRegister.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/4.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseModel.h"

/*
 "add_time" = 1472979611;
 address = "<null>";
 "an_id" = 11;
 area = "<null>";
 city = "<null>";
 county = "<null>";
 email = "<null>";
 id = 11;
 img = "<null>";
 level = "<null>";
 nickname = 13426090573;
 password = eabd8ce9404507aa8c22714d3f5eada9;
 pid = "<null>";
 province = "<null>";
 tphone = "<null>";
 "updated_at" = "<null>";
 username = 13426090573;
 */

@interface AMRegister : AMBaseModel

@property(nonatomic,assign)NSInteger add_time;

@property(nonatomic,copy)NSString *address;

@property(nonatomic,assign)NSInteger an_id;

@property(nonatomic,copy)NSString *area;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *county;

@property(nonatomic,copy)NSString*email;

@property(nonatomic,assign)NSInteger user_id;

@property(nonatomic,copy)NSString *img;

@property(nonatomic,copy)NSString *level;

@property(nonatomic,copy)NSString *nickname;

@property(nonatomic,copy)NSString *password;

@property(nonatomic,copy)NSString *pid;

@property(nonatomic,copy)NSString *province;

@property(nonatomic,copy)NSString *tphone;

@property(nonatomic,copy)NSString *updated_at;

@property(nonatomic,copy)NSString *username;

@end
