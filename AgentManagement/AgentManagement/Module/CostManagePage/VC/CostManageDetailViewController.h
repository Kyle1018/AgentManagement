//
//  CostManageDetailViewController.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "BaseTableViewController.h"
#import "AMProductInfo.h"

typedef void(^TapDeleteProductBlock)();

@interface CostManageDetailViewController : BaseTableViewController

@property(nonatomic,strong)AMProductInfo *productInfo;

@property(nonatomic,copy)TapDeleteProductBlock tapDeleteProductBlock;
@end
