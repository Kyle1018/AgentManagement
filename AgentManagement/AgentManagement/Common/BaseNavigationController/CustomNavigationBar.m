//
//  CustomNavigationBar.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/2.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar


- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // 初始化界面
    [self initAllView];
}

- (void)initAllView {
   // self.backgroundColor = [UIColor greenColor];
//    self.leftButton.backgroundColor = [UIColor clearColor];
//    self.titileLabel.backgroundColor = [UIColor clearColor];
//    self.rightView.backgroundColor = [UIColor clearColor];
    // 默认右侧按钮隐藏
    //self.rightView.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
