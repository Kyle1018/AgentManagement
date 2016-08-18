//
//  AddCustomerViewControllerB.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/16.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddCustomerViewControllerB.h"

@interface AddCustomerViewControllerB ()

@end

@implementation AddCustomerViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark -UITabelViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 44;
}

@end
