//
//  MaskView.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/7.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView

+ (MaskView*)showAddTo:(UIView*)view; {
    
    MaskView *maskView = [MaskView create:view];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        maskView.alpha = 0.3;
    }];
    
    return maskView;
}

+ (MaskView*)create:(UIView*)view {
    
    MaskView *maskView = [[MaskView alloc]initWithFrame:view.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [maskView addGestureRecognizer:tap];
    
    [[tap rac_gestureSignal]subscribeNext:^(id x) {
       
        if (maskView.hideMaskViewBlock) {
            
            maskView.hideMaskViewBlock();
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            
            maskView.alpha = 0;
        }];
        
        [maskView removeFromSuperview];
    }];



    [view addSubview:maskView];
    
    return maskView;
}

+ (void)hideRemoveTo:(UIView*)view; {
    

    for (UIView *view in view.subviews) {
        
        if ([view isKindOfClass:[MaskView class]]) {
            
            
            [UIView animateWithDuration:0.3 animations:^{
            
                view.alpha = 0;
            }];
                
            [view removeFromSuperview];
        }
    }
    
}



@end
