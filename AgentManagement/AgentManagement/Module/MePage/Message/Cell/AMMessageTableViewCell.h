//
//  AMMessageTableViewCell.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMMessage.h"

extern NSString *const kMessageCellIdentify;

@interface AMMessageTableViewCell : UITableViewCell

+ (CGFloat)cellHeightForMessage:(AMMessage *)message;

- (void)updateWithMessage:(AMMessage *)message;

@end
