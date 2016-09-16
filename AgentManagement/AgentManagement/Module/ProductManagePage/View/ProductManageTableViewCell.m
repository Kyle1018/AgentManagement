//
//  ProductManageTableViewCell.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "ProductManageTableViewCell.h"
#import "AMProductInfo.h"
@implementation ProductManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(AMProductInfo *)model {
    
    if (model == nil) {
        
        self.brand.text =@"品牌";
        
        self.pModel.text = @"产品型号";
        
        self.price.text = @"零售价格";
        
        [self.seeDetailBtn setTitle:@"操作" forState:UIControlStateNormal];
        
        self.seeDetailBtn.titleLabel.textColor
        =self.brand.textColor
        =self.pModel.textColor
        =self.price.textColor
        =[UIColor colorWithHex:@"000000"];
        
    }
    else {
        
        self.brand.text = model.brand;
        
        self.pModel.text = model.pmodel;
        
        self.price.text = model.price;
        
        [self.seeDetailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        
        [self.seeDetailBtn setTitleColor:[UIColor colorWithHex:@"4a4a4a"] forState:UIControlStateNormal];
        
        self.brand.textColor = self.pModel.textColor = self.price.textColor = [UIColor colorWithHex:@"4a4a4a"];
    }
    
}



- (IBAction)seeDetailAction:(UIButton *)sender {
    
    if (self.tapSeeDetailBlock) {
        
        self.tapSeeDetailBlock();
    }
}
@end
