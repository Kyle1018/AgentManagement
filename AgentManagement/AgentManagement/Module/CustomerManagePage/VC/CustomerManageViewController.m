//
//  CustomerManageViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CustomerManageViewController.h"
#import "CustomerDetailViewController.h"
#import "CustomerManageCell.h"
@interface CustomerManageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CustomerManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CustomerManageCellID";
    
    CustomerManageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell= [[CustomerManageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    return cell;
}



@end
