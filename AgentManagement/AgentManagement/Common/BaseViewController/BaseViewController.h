//
//  BaseViewController.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/7/30.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL leftButtonHidden;
@property (nonatomic, assign) BOOL rightButtonHidden;

@property (nonatomic, strong) UIColor *navBgColor; // 导航栏背景色

@property (readonly, nonatomic, strong) UIButton *leftButton;
@property (readonly, nonatomic, strong) UIButton *rightButton;
@property (readonly, nonatomic, strong) UILabel *centerLabel;

- (void)replaceDefaultNavBar:(UIView *)nav;

@end
