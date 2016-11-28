//
//  AMAdministratorTableViewCell.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAdministratorTableViewCell.h"

NSString *const kAdministratorCellIdentifier = @"kAdministratorCellIdentifier-fjadlj";

@interface AMAdministratorTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *operateLabel;
@property (nonatomic, weak) IBOutlet UIButton *operateButton;
@property (nonatomic, weak) IBOutlet UIView *bottomLineView;

@property (nonatomic, strong) AMAdministrators *administrator;

@end

@implementation AMAdministratorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    @weakify(self);
    [[self.operateButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.tapAdministratorDetail) {
            self.tapAdministratorDetail(self.administrator);
        }
    }];
}

- (NSString *)reuseIdentifier {
    return kAdministratorCellIdentifier;
}

- (void)updateWithAdministrator:(AMAdministrators *)administrator isTitle:(BOOL)isTitle {
    self.administrator = administrator;
    self.nameLabel.textColor = self.phoneLabel.textColor = self.operateLabel.textColor = (isTitle ? [UIColor colorWithHex:@"000000"] : [UIColor colorWithHex:@"4a4a4a"]);
    self.nameLabel.text = administrator.nickname;
    self.phoneLabel.text = administrator.username;
    self.operateLabel.text = (isTitle ? @"操作" : @"详情");
    self.operateButton.enabled = !isTitle;
}

- (void)setBottomLineShown:(BOOL)shown {
    self.bottomLineView.hidden = !shown;
}

@end
