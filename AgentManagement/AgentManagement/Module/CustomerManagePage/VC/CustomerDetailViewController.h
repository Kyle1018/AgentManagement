//
//  CustomerDetailViewController.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/18.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "BaseTableViewController.h"
#import "AMCustomer.h"

@interface CustomerDetailViewController : BaseTableViewController

@property(nonatomic,strong)AMCustomer *customerModel;

@end
