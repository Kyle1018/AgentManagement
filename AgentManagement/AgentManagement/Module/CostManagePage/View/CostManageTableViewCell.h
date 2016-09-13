//
//  CostManageTableViewCell.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMProductInfo.h"

typedef void(^TapSeeDetailBlock)();

@interface CostManageTableViewCell : UITableViewCell

@property(nonatomic,strong)AMProductInfo *productInfo;
@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UILabel *pmodel;
@property (weak, nonatomic) IBOutlet UILabel *stock_number;
@property (weak, nonatomic) IBOutlet UIButton *seeDetailBtn;
@property(nonatomic,copy)TapSeeDetailBlock tapSeeDetailBlock;
@end
