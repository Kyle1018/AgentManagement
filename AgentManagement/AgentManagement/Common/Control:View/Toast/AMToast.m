//
//  AMToast.m
//  PuRunMedical
//
//  Created by Kyle on 16/7/31.
//  Copyright © 2016年 PuRun. All rights reserved.
//

#import "AMToast.h"
#import "MBProgressHUD.h"

@implementation AMToast

+ (MBProgressHUD *)initHUDonView:(UIView *)view
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    
    HUD.minSize = CGSizeMake(125, 125);
    return HUD;
}

+ (void)showDefaultLoadingOnView:(UIView *)view
{
    if (!view) {
        return;
    }
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [self initHUDonView:view];
    
    hud.labelText = @"正在加载...";
    [view addSubview:hud];
    [hud show:YES];
}

+ (void)showLoadingMessage:(NSString *)message onView:(UIView *)view
{
    if (!view) {
        return;
    }
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [self initHUDonView:view];
    
    hud.labelText = message;
    [view addSubview:hud];
    [hud show:YES];
}

+ (void)showAutoDisappearMessage:(NSString *)message onView:(UIView *)view
{
    if (!view) {
        return;
    }
    [MBProgressHUD hideHUDForView:view animated:NO];
    MBProgressHUD *hud = [self initHUDonView:view];
    
    hud.labelText = message;
    [view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1.5];
}

+ (void)dismissOnView:(UIView *)view
{
    if (!view) {
        return;
    }
    [self dismissOnView:view animate:YES];
}

+ (void)dismissOnView:(UIView *)view animate:(BOOL)animate
{
    if (!view) {
        return;
    }
    [MBProgressHUD hideAllHUDsForView:view animated:animate];
}

+ (void)dismissWithMessage:(NSString *)message onView:(UIView *)view
{
    if (!view) {
        return;
    }
    [self dismissOnView:view animate:NO];
    [self showAutoDisappearMessage:message onView:view];
}

@end
