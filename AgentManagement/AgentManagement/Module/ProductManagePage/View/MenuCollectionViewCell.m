//
//  MenuCollectionViewCell.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "MenuCollectionViewCell.h"

@implementation MenuCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
}


- (void)setTitleData:(NSString*)text backgroundColor:(UIColor*)bgColor titleColor:(UIColor*)titleColor {
    
    self.optionLabel.text = text;
    
    self.optionLabel.backgroundColor = bgColor;
    
    self.optionLabel.textColor = titleColor;
    
}




@end
