//
//  AMUser.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/4.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseModel.h"

@interface AMUser : AMBaseModel

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
