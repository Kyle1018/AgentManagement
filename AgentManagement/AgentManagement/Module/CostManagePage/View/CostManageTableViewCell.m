//
//  CostManageTableViewCell.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CostManageTableViewCell.h"

@implementation CostManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProductInfo:(AMProductInfo *)productInfo {
    
    if (productInfo == nil) {
        
        self.brand.text =@"品牌";
        
        self.pmodel.text = @"产品型号";
        
        self.stock_number.text = @"进货数量";
        
        [self.seeDetailBtn setTitle:@"操作" forState:UIControlStateNormal];
        
        self.seeDetailBtn.titleLabel.textColor
        =self.stock_number.textColor
        =self.pmodel.textColor
        =self.brand.textColor
        =[UIColor colorWithHex:@"000000"];
        
    }
    else {
        
        self.brand.text = productInfo.brand;
        
        self.pmodel.text = productInfo.pmodel;
        
        self.stock_number.text = productInfo.stock_number;
        
        [self.seeDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    
        self.seeDetailBtn.titleLabel.textColor
        =self.stock_number.textColor
        =self.pmodel.textColor
        =self.brand.textColor
        =[UIColor colorWithHex:@"4a4a4a"];
    }
    
}


- (IBAction)seeDetailAction:(UIButton *)sender {
    
    if (self.tapSeeDetailBlock) {
        
        self.tapSeeDetailBlock();
    }
}

@end
