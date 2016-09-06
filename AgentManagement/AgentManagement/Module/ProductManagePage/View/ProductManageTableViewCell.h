//
//  ProductManageTableViewCell.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMProductInfo;

@interface ProductManageTableViewCell : UITableViewCell

@property(nonatomic,strong)AMProductInfo *model;
@property (strong, nonatomic) IBOutlet UILabel *brand;
@property (strong, nonatomic) IBOutlet UILabel *pModel;
@property (strong, nonatomic) IBOutlet UILabel *price;

@end
