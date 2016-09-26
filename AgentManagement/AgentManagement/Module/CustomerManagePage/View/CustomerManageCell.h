//
//  CustomerManageCell.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/30.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMCustomer.h"

typedef void(^TapSeeDetailBlock)();

@interface CustomerManageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *customerName;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *administratorName;
@property(nonatomic,copy)TapSeeDetailBlock tapSeeDetailBlock;
@property (weak, nonatomic) IBOutlet UIButton *seeDetailBtn;
- (void)setData:(AMCustomer*)customer;

@end
