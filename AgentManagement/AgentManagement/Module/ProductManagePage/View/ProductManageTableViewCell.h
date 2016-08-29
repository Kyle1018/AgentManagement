//
//  ProductManageTableViewCell.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapSeeDetailBlock)();
@interface ProductManageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *seeDetail;
@property (nonatomic,copy)TapSeeDetailBlock tapSeeDetailBlock;
@end
