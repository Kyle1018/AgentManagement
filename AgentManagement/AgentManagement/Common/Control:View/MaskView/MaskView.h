//
//  MaskView.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/7.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HideMaskViewBlock)();

@interface MaskView : UIView

@property(nonatomic,copy)HideMaskViewBlock hideMaskViewBlock;

+ (MaskView*)showAddTo:(UIView*)view;

+ (void)hideRemoveTo:(UIView*)view;

@end
