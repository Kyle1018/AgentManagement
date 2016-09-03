//
//  RegexUtils.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexUtils : NSObject

//匹配手机号
+(BOOL)checkTelNumber:(NSString*)telNumber;

//匹配用户密码6-18位数字和字母组合
+(BOOL)checkPassword:(NSString*)password;


@end
