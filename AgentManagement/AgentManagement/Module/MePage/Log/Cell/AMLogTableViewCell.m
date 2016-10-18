//
//  AMLogTableViewCell.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMLogTableViewCell.h"

NSString *const kLogCellIdentifier = @"kLogCellIdentifier-jfladj";

@interface AMLogTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *operatorLabel;
@property (nonatomic, weak) IBOutlet UILabel *levelLabel;
@property (nonatomic, weak) IBOutlet UILabel *pageLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *opLabel;
@property (nonatomic, weak) IBOutlet UIButton *opButton;
@property (nonatomic, weak) IBOutlet UIView *bottomLineView;

@property (nonatomic, strong) AMLog *log;

@end

@implementation AMLogTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    @weakify(self);
    [[self.opButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.tapLogDetail) {
            self.tapLogDetail(self.log);
        }
    }];
}

- (NSString *)reuseIdentifier {
    return kLogCellIdentifier;
}

- (void)updateWithLog:(AMLog *)log isBold:(BOOL)isBold {
    self.log = log;
    
    self.operatorLabel.textColor = self.levelLabel.textColor = self.pageLabel.textColor = self.timeLabel.textColor = self.opLabel.textColor = isBold ? [UIColor colorWithHex:@"000000"] : [UIColor colorWithHex:@"4a4a4a"];
    self.opButton.enabled = !isBold;
    self.operatorLabel.text = nil;
    self.levelLabel.text = nil;
    self.pageLabel.text = nil;
    self.timeLabel.text = nil;
    self.opLabel.text = isBold ? @"操作" : @"详情";
}

- (void)setBottomLineShown:(BOOL)shown {
    self.bottomLineView.hidden = !shown;
}

@end
