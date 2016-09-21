//
//  AMCustomer.h
//  AgentManagement
//
//  Created by huabin on 16/9/20.
//  Copyright © 2016年 KK. All rights reserved.
//

/*
 "a_id" = 1;
 address = "\U77f3\U6797\U5c0f\U533a";
 "an_id" = 10;
 chlorine = 33;
 city = "\U5317\U4eac\U5e02";
 county = "\U4e1c\U57ce\U533a";
 hardness = 22;
 id = 16;
 name = "\U77f3\U6797";
 ph = 122;
 phone = 13501167925;
 province = "\U5317\U4eac";
 "s_id" = 5;
 tds = 12;
 "u_id" = 10;
 */

#import "AMBaseModel.h"
#import "AMOrder.h"
@interface AMCustomer : AMBaseModel

@property(nonatomic,assign)NSInteger a_id;//所属管理员

@property(nonatomic,copy)NSString *address;//详细地址

@property(nonatomic,assign)NSInteger an_id;

@property(nonatomic,assign)NSInteger chlorine;//余氯值

@property(nonatomic,copy)NSString *city;//城市

@property(nonatomic,copy)NSString *county;//区

@property(nonatomic,assign)NSInteger hardness;//'硬度',

@property(nonatomic,assign)NSInteger c_id;//客户id

@property(nonatomic,copy)NSString *name;//客户姓名

@property(nonatomic,assign)NSInteger ph;//'PH值',

@property(nonatomic,copy)NSString* phone;//手机号码

@property(nonatomic,copy)NSString *province;//省份

@property(nonatomic,assign)NSInteger s_id;//所属销售

@property(nonatomic,assign)NSInteger tds;//'TDS值

@property(nonatomic,assign)NSInteger u_id;

@property(nonatomic,strong) NSArray<AMOrder*>* orderArray;

@end
