//
//  BaseViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/7/30.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ViewControllerBG"]];
    
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 80, 44);
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor colorWithHex:@"47b6ff"] forState:UIControlStateNormal];
        backBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
        [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        [backBtn setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0 , 0, 30)];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem=backItem;
    }
    
}

-(void)doBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
