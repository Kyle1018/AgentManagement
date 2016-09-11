//
//  PickerView.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/10.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "PickerView.h"

@implementation PickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (PickerView*)loadFromNib {
    
    PickerView *pickerView = [[[NSBundle mainBundle]loadNibNamed:@"PickerView" owner:nil options:nil]lastObject];
    
    
    pickerView.backgroundColor = [UIColor colorWithHex:@"4a4a4a" alpha:0];
    pickerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    pickerView.pickerBGView.originY = ScreenHeight;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [pickerView addGestureRecognizer:tap];
    [[tap rac_gestureSignal]subscribeNext:^(id x) {
       
        [UIView animateWithDuration:0.3 animations:^{
            
            pickerView.backgroundColor = [UIColor colorWithHex:@"4a4a4a" alpha:0];
            pickerView.pickerBGView.originY = ScreenHeight;
            
        } completion:^(BOOL finished) {
            
            [pickerView removeFromSuperview];
        }];
        
    }];
    
    [[pickerView.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       
        [UIView animateWithDuration:0.3 animations:^{
            
            pickerView.backgroundColor = [UIColor colorWithHex:@"4a4a4a" alpha:0];
            pickerView.pickerBGView.originY = ScreenHeight;
            
        } completion:^(BOOL finished) {
            
            [pickerView removeFromSuperview];
            
            if (pickerView.tapConfirmBlock) {
                
                pickerView.tapConfirmBlock();
            }
    
        }];
        
    }];
    
    
    [[pickerView.cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       
        [UIView animateWithDuration:0.3 animations:^{
            
            pickerView.backgroundColor = [UIColor colorWithHex:@"4a4a4a" alpha:0];
           // pickerView.pickerBGView.originY = ScreenHeight;
            
        } completion:^(BOOL finished) {
            
            [pickerView removeFromSuperview];
          
          
        }];
    }];
    
    
    return pickerView;
}



+ (PickerView*)showAddTo:(UIView*)view{
    
    PickerView *pickerView = [self loadFromNib];
    [view addSubview:pickerView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        pickerView.backgroundColor = [UIColor colorWithHex:@"4a4a4a" alpha:0.3];
        //pickerView.pickerBGView.originY = ScreenHeight-224;
       
        
    } completion:^(BOOL finished) {
        
    }];
    
    return pickerView;
}

@end
