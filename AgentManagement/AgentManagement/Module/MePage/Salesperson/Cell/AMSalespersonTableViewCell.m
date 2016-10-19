//
//  AMSalespersonTableViewCell.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMSalespersonTableViewCell.h"

NSString *const kSalespersonCellIdentifier = @"kSalespersonCellIdentifier-fjalj";

@interface AMSalespersonTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *operateLabel;
@property (nonatomic, weak) IBOutlet UIButton *operateButton;
@property (nonatomic, weak) IBOutlet UIView *bottomLineView;

@property (nonatomic, strong) AMSales *sales;

@end

@implementation AMSalespersonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    @weakify(self);
    [[self.operateButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.tapSalespersonDetail) {
            self.tapSalespersonDetail(self.sales);
        }
    }];
}

- (NSString *)reuseIdentifier {
    return kSalespersonCellIdentifier;
}

- (void)updateWithSales:(AMSales *)sales isTitle:(BOOL)isTitle {
    self.sales = sales;
    self.nameLabel.textColor = self.phoneLabel.textColor = self.operateLabel.textColor = (isTitle ? [UIColor colorWithHex:@"000000"] : [UIColor colorWithHex:@"4a4a4a"]);
    self.nameLabel.text = sales.name;
    self.phoneLabel.text = sales.phone;
    self.operateLabel.text = (isTitle ? @"操作" : @"详情");
    self.operateButton.enabled = !isTitle;
}

- (void)setBottomLineShown:(BOOL)shown {
    self.bottomLineView.hidden = !shown;
}

@end
