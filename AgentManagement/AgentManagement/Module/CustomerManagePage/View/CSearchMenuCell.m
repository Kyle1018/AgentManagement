//
//  CSearchMenuCell.m
//  AgentManagement
//
//  Created by huabin on 16/9/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CSearchMenuCell.h"

@implementation CSearchMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSectionIndex:(NSInteger)sectionIndex {
    
   // UILabel *label = [self.contentView viewWithTag:sectionIndex+2000];
    
    if (sectionIndex == 0) {
        
        self.inputTextField.placeholder = @"查询客户姓名、管理员姓名、售货员姓名";
        self.inputTextField.enabled = YES;
       
    }
    else if (sectionIndex == 1) {
        
        self.inputTextField.placeholder = @"输入客户手机号";
        self.inputTextField.enabled = YES;
        
    }
    else {
        
        self.inputTextField.placeholder = @"选择城市";
        self.inputTextField.enabled = NO;
        
    }

}

@end
