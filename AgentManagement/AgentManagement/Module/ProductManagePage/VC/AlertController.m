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
                
                if (self.optionName !=0) {

                    if (weakSelf.tapActionButtonBlock) {
                        
                        weakSelf.tapActionButtonBlock(self.optionName,[self keyName],i);
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
    
    switch (self.optionName) {
        case IsDrinking:
            
            return @"isDrinking";
            
            break;
            
        case Classification:
            
            return @"classification";
            
            break;
        case FilterMedia:
            
            return @"filterMedia";
            
            break;
        case ProductFeatures:
            
            return @"productFeatures";
            
            break;
        case FilterElementCounts:
            
            return @"filterElementCounts";
            
            break;
        case PlacingPosition:
            
            return @"placingPosition";
            
            break;
        case ApplyRegion:
            
            return @"applyRegion";
            
            break;
        case WholesalePrice:
            
            return @"wholesalePrice";
            
            break;
        case ChangeFilterElementCycle:
            
            return @"changeFilterElementCycle";
            
            break;
            
        default:
            break;
    }
}

@end
