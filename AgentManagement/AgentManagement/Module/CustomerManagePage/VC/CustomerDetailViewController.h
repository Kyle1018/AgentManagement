//
//  CustomerDetailViewController.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/18.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "BaseTableViewController.h"
#import "AMCustomer.h"

typedef void(^TapDeleteCustomerBlock)(NSInteger customer_id);

@interface CustomerDetailViewController : BaseTableViewController

@property(nonatomic,strong)AMCustomer *customerModel;

@property(nonatomic,copy)TapDeleteCustomerBlock tapDeleteCustomerBlock;

@end
