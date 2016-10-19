//
//  AMSalespersonTableViewCell.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSales.h"

extern NSString *const kSalespersonCellIdentifier;

typedef void (^TapSalespersonDetailBlock)(AMSales *sales);

@interface AMSalespersonTableViewCell : UITableViewCell

@property (nonatomic, copy) TapSalespersonDetailBlock tapSalespersonDetail;

- (void)updateWithSales:(AMSales *)sales isTitle:(BOOL)isTitle;
- (void)setBottomLineShown:(BOOL)shown;

@end
