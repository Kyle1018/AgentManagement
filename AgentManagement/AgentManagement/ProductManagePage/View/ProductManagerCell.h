//
//  ProductManagerCell.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapSeeDetailsBlock)();
@interface ProductManagerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *customerName;
@property (weak, nonatomic) IBOutlet UILabel *phoneName;
@property (weak, nonatomic) IBOutlet UILabel *administrators;
@property (weak, nonatomic) IBOutlet UILabel *seeDetails;
@property(nonatomic,copy)TapSeeDetailsBlock tapSeeDetailsBlock;
@end
