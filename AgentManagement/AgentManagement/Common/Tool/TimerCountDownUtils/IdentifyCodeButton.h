//
//  IdentifyCodeButton.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface IdentifyCodeButton : UIButton

@property (nonatomic, copy) IBInspectable NSString *identifyKey;
@property (nonatomic, strong) IBInspectable UIColor *disabledBackgroundColor;
@property (nonatomic, strong) IBInspectable UIColor *disabledTitleColor;

- (void)start;


@end
