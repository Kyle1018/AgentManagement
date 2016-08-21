//
//  AlertController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/20.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AlertController.h"

@interface AlertController ()

@end

@implementation AlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.preferredStyle == UIAlertControllerStyleActionSheet) {
        
        NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:self.title];
        [hogan addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:20.0]
                      range:NSMakeRange(0, self.title.length)];
        [self setValue:hogan forKey:@"attributedTitle"];
        
        __weak typeof(self) weakSelf = self;
        
        for (int i = 0; i < self.actionButtonArray.count; i++) {
            
            NSString *msg = self.actionButtonArray[i];
            
            [self addAction:[UIAlertAction actionWithTitle:msg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                

                if (weakSelf.tapActionButtonBlock) {
                    
                    weakSelf.tapActionButtonBlock(self.kTag,i);
                }
                
            }]];
            
        }
        
        
        NSString *msg = @"取消";
        
        [self addAction:[UIAlertAction actionWithTitle:msg style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        
    }
    
    else {
        

        [self addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (self.tapExitButtonBlock) {
            
                self.tapExitButtonBlock();
            }
           
        }]];
        
        [self addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }]];
 
 
    }
    

}



@end
