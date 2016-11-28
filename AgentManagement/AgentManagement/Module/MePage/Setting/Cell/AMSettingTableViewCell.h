//
//  AMSettingTableViewCell.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kSettingCellIdentifier;

@interface AMSettingTableViewCell : UITableViewCell

- (void)updateWithTitle:(NSString *)title subtitle:(NSString *)subtitle isImageCell:(BOOL)isImgeCell;

@end
