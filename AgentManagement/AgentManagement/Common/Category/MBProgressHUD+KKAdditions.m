//
//  MBProgressHUD+KKAdditions.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "MBProgressHUD+KKAdditions.h"

@implementation MBProgressHUD (KKAdditions)

+ (MBProgressHUD *)createHUD
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    [window addSubview:HUD];
    [HUD show:YES];
    HUD.removeFromSuperViewOnHide = YES;
    
    return HUD;
}

//纯文字提示
+ (MBProgressHUD *)showText:(NSString*)text
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD];
    HUD.mode = MBProgressHUDModeText;

    HUD.detailsLabelText = text;
    HUD.detailsLabelFont = [UIFont fontWithName:@"Arial" size:16];
    
    [HUD hide:YES afterDelay:4];
    return HUD;
}

@end
