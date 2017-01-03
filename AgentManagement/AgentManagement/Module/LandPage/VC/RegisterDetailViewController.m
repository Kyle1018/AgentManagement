//
//  RegisterDetailViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 17/1/3.
//  Copyright © 2017年 KK. All rights reserved.
//

#import "RegisterDetailViewController.h"

@interface RegisterDetailViewController ()

@end

@implementation RegisterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"填写详细信息";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 30;
    }
    else {
        
        return 10;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    return headerView;
}

@end
