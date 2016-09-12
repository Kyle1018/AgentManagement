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
#import "CSearchMenuViewController.h"
@interface CustomerManageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)CSearchMenuViewController *cSearchMenuVC;

@end

@implementation CustomerManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    
}

- (void)requestData {
    
    
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


- (IBAction)searchMenuAction:(UIButton *)sender {
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"CustomerManage" bundle:nil];
    _cSearchMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"CSearchMenuID"];
    [[UIApplication sharedApplication].keyWindow addSubview:_cSearchMenuVC.view];
}

@end
