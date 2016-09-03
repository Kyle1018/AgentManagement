//
//  RegexUtils.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "RegexUtils.h"

@implementation RegexUtils


//匹配手机号
+ (BOOL)checkTelNumber:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}

//匹配用户密码6-18位数字和字母组合
+(BOOL)checkPassword:(NSString*)password {
    
    NSString*pattern=@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    
    NSPredicate*pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch=[pred evaluateWithObject:password];
    
    return isMatch;
}



@end
