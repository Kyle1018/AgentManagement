//
//  AMUser.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/4.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseModel.h"

@interface AMUser : AMBaseModel

@property(nonatomic,copy)NSString* add_time;//

@property(nonatomic,copy)NSString *address;

@property(nonatomic,copy)NSString* an_id;//

@property(nonatomic,copy)NSString *area;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *county;

@property(nonatomic,copy)NSString*email;

@property(nonatomic,copy)NSString* user_id;//

@property(nonatomic,copy)NSString *img;

@property(nonatomic,copy)NSString *level;

@property(nonatomic,copy)NSString *nickname;

@property(nonatomic,copy)NSString *password;

@property(nonatomic,copy)NSString *pid;

@property(nonatomic,copy)NSString *province;

@property(nonatomic,copy)NSString *tphone;

@property(nonatomic,copy)NSString *updated_at;

@property(nonatomic,copy)NSString *username;

/**
 *     [province]: <nil>
 [user_id]: 0
 [nickname]: 13501167925
 [img]: <nil>
 [updated_at]: 0
 [city]: <nil>
 [resultCode]: 0
 [level]: 0
 [email]:
 [add_time]: 1472782222
 [resultMessage]: ok
 [area]: <nil>
 [county]: <nil>
 [an_id]: 10
 [pid]: 0
 [password]: eabd8ce9404507aa8c22714d3f5eada9
 [tphone]: <nil>
 [data]: <nil>
 [address]: <nil>
 [username]: 13501167925
 */
@end
