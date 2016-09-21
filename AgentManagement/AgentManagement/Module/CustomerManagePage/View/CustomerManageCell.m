//
//  CustomerManageCell.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/30.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CustomerManageCell.h"

@implementation CustomerManageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(AMCustomer*)customer {
    
    if (customer == nil) {
        
        self.customerName.text =@"客户姓名";
        
        self.phone.text = @"手机号";
        
        self.administratorName.text = @"管理员";
        
        [self.seeDetailBtn setTitle:@"操作" forState:UIControlStateNormal];
        
        self.seeDetailBtn.titleLabel.textColor
        =self.customerName.textColor
        =self.phone.textColor
        =self.administratorName.textColor
        =[UIColor colorWithHex:@"000000"];
    }
    else {
        
        self.customerName.text = customer.name;
        
        self.phone.text = customer.phone;
        
        self.administratorName.text = [NSString stringWithFormat:@"%ld",customer.a_id];
        
        [self.seeDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        
        [self.seeDetailBtn setTitleColor:[UIColor colorWithHex:@"4a4a4a"] forState:UIControlStateNormal];
        
        self.customerName.textColor = self.phone.textColor = self.administratorName.textColor = [UIColor colorWithHex:@"4a4a4a"];
        
    }
    
}

- (IBAction)seeDetailAction:(UIButton *)sender {
    
    if (self.tapSeeDetailBlock) {
        
        self.tapSeeDetailBlock();
    }
}

@end
