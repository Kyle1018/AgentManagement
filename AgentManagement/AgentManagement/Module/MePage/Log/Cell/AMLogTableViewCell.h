//
//  AMLogTableViewCell.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMLog.h"

extern NSString *const kLogCellIdentifier;

typedef void (^TapLogDetailBlock)(AMLog *log);

@interface AMLogTableViewCell : UITableViewCell

@property (nonatomic, copy) TapLogDetailBlock tapLogDetail;

- (void)updateWithLog:(AMLog *)log isBold:(BOOL)isBold;
- (void)setBottomLineShown:(BOOL)shown;

@end
