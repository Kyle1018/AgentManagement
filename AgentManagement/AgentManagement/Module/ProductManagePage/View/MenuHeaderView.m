//
//  MenuHeaderView.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "MenuHeaderView.h"

@implementation MenuHeaderView

- (IBAction)tapAllButtonAction:(UIControl *)sender {
    
    if (self.tapAllButonBlock) {
        
        self.tapAllButonBlock();
    }
}

@end
