//
//  CustomerManageViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CustomerManageViewController.h"
#import "ProductManagerCell.h"
#import "CustomerDetailViewController.h"
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
    
    static NSString *cellID = @"CellId";
    
   ProductManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell =[[ProductManagerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    //点击表格查看详情跳转——客户详情页面
    __weak typeof(self) weakSelf = self;
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"CustomerManage" bundle:nil];
    CustomerDetailViewController*customerDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"CustomerDetailID"];
    //点击了查看详情
    cell.tapSeeDetailsBlock = ^() {
        
        [weakSelf.navigationController pushViewController:customerDetailVC animated:YES];
    };
    
    return cell;
}



@end
