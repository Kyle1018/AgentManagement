//
//  ProductManagerCell.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "ProductManagerCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@implementation ProductManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    __weak typeof(self) weakSelf = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [self.seeDetails addGestureRecognizer:tap];
    
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        
        if (weakSelf.tapSeeDetailsBlock) {
            
            weakSelf.tapSeeDetailsBlock();
        }
     
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
