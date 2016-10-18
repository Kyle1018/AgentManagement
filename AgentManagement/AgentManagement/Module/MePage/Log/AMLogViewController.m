//
//  AMLogViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMLogViewController.h"

@interface AMLogViewController ()

@property (nonatomic, weak) IBOutlet UITableView *logTableView;

@end

@implementation AMLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeControl {
    self.title = @"操作日志";
}

@end
