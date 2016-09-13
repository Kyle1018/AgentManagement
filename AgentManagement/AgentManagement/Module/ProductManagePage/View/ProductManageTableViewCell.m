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
    
    self.brand.text = model.brand;
    
    self.pModel.text = model.pmodel;
    
    self.price.text = model.price;
}



- (IBAction)seeDetailAction:(UIButton *)sender {
    
    if (self.tapSeeDetailBlock) {
        
        self.tapSeeDetailBlock();
    }
}
@end
