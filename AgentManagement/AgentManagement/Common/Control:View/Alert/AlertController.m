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

        if (self.title !=nil) {
            
            NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:self.title];
            [hogan addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:20.0]
                          range:NSMakeRange(0, self.title.length)];
            [self setValue:hogan forKey:@"attributedTitle"];
        }

        __weak typeof(self) weakSelf = self;
        
        for (int i = 0; i < self.actionButtonArray.count; i++) {
            
            NSString *msg = self.actionButtonArray[i];
            
          
                       
            [self addAction:[UIAlertAction actionWithTitle:msg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                if (weakSelf.alertTag !=0) {

                    if (weakSelf.tapActionButtonBlock) {
                        
                        weakSelf.tapActionButtonBlock(weakSelf.alertTag,[self keyName],i);
                    }
                    
                }
                
                else {
                    
                    if (weakSelf.tapActionButtonBlock) {
                        
                        weakSelf.tapActionButtonBlock(0,nil,i);
                    }
                }
                
            }]];
            
        }
        
        
        NSString *msg = @"取消";
        
        [self addAction:[UIAlertAction actionWithTitle:msg style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        
    }
    
    else {
        
        if (!self.alertOptionName) {
            
            self.alertOptionName = @[@"取消",@"退出"];
        }

        [self addAction:[UIAlertAction actionWithTitle:self.alertOptionName[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (self.tapExitButtonBlock) {
            
                self.tapExitButtonBlock();
            }
           
        }]];
        
        [self addAction:[UIAlertAction actionWithTitle:self.alertOptionName[1] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            

        }]];
 
 
    }
    
}



- (NSString*)keyName {
    
    switch (self.alertTag) {
        case 300:
            
            return @"drinking";
            
            break;
            
        case 301:
            
            return @"classification";
            
            break;
        case 302:
            
            return @"filter";
            
            break;
        case 303:
            
            return @"features";
            
            break;
        case 304:
            
            return @"number";
            
            break;
        case 305:
            
            return @"putposition";
            
            break;
        case 306:
            
            return @"area";
            
            break;
        case 307:
            
            return @"price";
            
            break;
        case 309:
            
            return @"cycle";
            
            break;
            
        default:
            
            return nil;
            break;
    }
}



@end
