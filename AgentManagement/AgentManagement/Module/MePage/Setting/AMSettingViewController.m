//
//  AMSettingViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMSettingViewController.h"

@interface AMSettingViewController ()

@end

@implementation AMSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeControl {
    self.title = @"设置";
}

@end
