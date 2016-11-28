//
//  AMSettingTableViewCell.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMSettingTableViewCell.h"

NSString *const kSettingCellIdentifier = @"kSettingCellIdentifier-fdalj";

@interface AMSettingTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *settingTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *settingSubtitleLabel;
@property (nonatomic, weak) IBOutlet UIView *portraitView;

@end

@implementation AMSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.portraitView.layer.masksToBounds = YES;
    self.portraitView.layer.borderColor = [UIColor colorWithHex:@"e7e7e7"].CGColor;
    self.portraitView.layer.borderWidth = 1.;
    self.portraitView.layer.cornerRadius = self.portraitView.width / 2;
}

- (NSString *)reuseIdentifier {
    return kSettingCellIdentifier;
}

- (void)updateWithTitle:(NSString *)title subtitle:(NSString *)subtitle isImageCell:(BOOL)isImgeCell {
    self.portraitView.hidden = !isImgeCell;
    self.settingTitleLabel.text = title;
    self.settingSubtitleLabel.text = subtitle;
}

@end
