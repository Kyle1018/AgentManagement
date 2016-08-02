//
//  BaseNavigationController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"ddd");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // 隐藏默认导航栏
    self.navigationBarHidden = NO; // 使右滑返回手势可用
    self.navigationBar.hidden = YES; // 隐藏导航栏
}



@end
