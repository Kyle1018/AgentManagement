//
//  AMAdministatorViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAdministatorViewController.h"

@interface AMAdministatorViewController ()

@end

@implementation AMAdministatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeControl {
    self.title = @"管理员管理";
}

@end
