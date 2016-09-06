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

- (void)setData:(AMProductInfo*)productInfo index:(NSInteger)index {
    
    self.brand.text = productInfo.brand;
    
    self.pModel.text = productInfo.pmodel;
    
    self.price.text = productInfo.price;
    
    _index = index;
}



- (IBAction)seeDetailAction:(UIButton *)sender {
    
    if (self.tapSeeDetailBlock) {
        
        self.tapSeeDetailBlock(_index);
    }
}
@end
