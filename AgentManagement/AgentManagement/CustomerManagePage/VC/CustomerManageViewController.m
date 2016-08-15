//
//  CustomerManageViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CustomerManageViewController.h"

@interface CustomerManageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CustomerManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.titleStr = @"客户管理";
    // Do any additional setup after loading the view.
//    
//    self.navigationItem.backBarButtonItem
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CellId";
    
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}

@end
