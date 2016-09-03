//
//  MBProgressHUD+KKAdditions.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (KKAdditions)

//纯文字提示
+ (MBProgressHUD *)showText:(NSString*)text;

@end
