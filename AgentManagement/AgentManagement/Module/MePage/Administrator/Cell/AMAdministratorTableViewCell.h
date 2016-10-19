//
//  AMAdministratorTableViewCell.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMAdministrators.h"

extern NSString *const kAdministratorCellIdentifier;

typedef void (^TapAdministratorDetailBlock)(AMAdministrators *administrator);

@interface AMAdministratorTableViewCell : UITableViewCell

@property (nonatomic, copy) TapAdministratorDetailBlock tapAdministratorDetail;

- (void)updateWithAdministrator:(AMAdministrators *)administrator isTitle:(BOOL)isTitle;
- (void)setBottomLineShown:(BOOL)shown;

@end
