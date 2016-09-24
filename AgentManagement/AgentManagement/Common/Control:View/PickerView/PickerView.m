//
//  PickerView.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/10.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "PickerView.h"

@implementation PickerView

+ (PickerView*)loadFromNib:(NSInteger)index addToView:(UIView*)view {
    
    PickerView *pickerView = [[[NSBundle mainBundle]loadNibNamed:@"PickerView" owner:nil options:nil]objectAtIndex:index];
    pickerView.backgroundColor = [UIColor colorWithHex:@"4a4a4a" alpha:0];
    pickerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    [view addSubview:pickerView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        pickerView.backgroundColor = [UIColor colorWithHex:@"4a4a4a" alpha:0.3];
      
      //  pickerView.picker.backgroundColor=[UIColor redColor];
       // pickerView.picker.bottom = view.bottom;
        
        

    } completion:^(BOOL finished) {
        
    }];
    
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

            if (pickerView.tapConfirmBlock) {
                
                pickerView.tapConfirmBlock();
            }
            
            [pickerView removeFromSuperview];
    
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
    
    PickerView *pickerView = [self loadFromNib:0 addToView:view];
  
    
    return pickerView;
}

@end

@implementation PickerDataView

+ (PickerDataView*)showDateAddTo:(UIView*)view {
    
    PickerDataView *datepickerView = [self loadPickerDataViewFromNibaddToView:view];
    
    return datepickerView;
}


+ (PickerDataView*)loadPickerDataViewFromNibaddToView:(UIView*)view {
    
    PickerDataView *pickerDataView = [[[NSBundle mainBundle]loadNibNamed:@"PickerView" owner:nil options:nil]objectAtIndex:1];
    pickerDataView.backgroundColor = [UIColor colorWithHex:@"4a4a4a" alpha:0];
    pickerDataView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    pickerDataView.pickerBGView.originY = ScreenHeight;
    
    [view addSubview:pickerDataView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        pickerDataView.backgroundColor = [UIColor colorWithHex:@"4a4a4a" alpha:0.3];
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [pickerDataView addGestureRecognizer:tap];
    [[tap rac_gestureSignal]subscribeNext:^(id x) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            pickerDataView.backgroundColor = [UIColor colorWithHex:@"4a4a4a" alpha:0];
 
        } completion:^(BOOL finished) {
            
            [pickerDataView removeFromSuperview];
        }];
        
    }];

    [[pickerDataView.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            pickerDataView.backgroundColor = [UIColor colorWithHex:@"4a4a4a" alpha:0];
            pickerDataView.pickerBGView.originY = ScreenHeight;
            
        } completion:^(BOOL finished) {
            
            if (pickerDataView.tapConfirmBlock) {
                
                pickerDataView.tapConfirmBlock();
            }
            
            [pickerDataView removeFromSuperview];
            
        }];
        
    }];

    
    [[pickerDataView.cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            pickerDataView.backgroundColor = [UIColor colorWithHex:@"4a4a4a" alpha:0];
            pickerDataView.pickerBGView.originY = ScreenHeight;
            
        } completion:^(BOOL finished) {
            
            [pickerDataView removeFromSuperview];
            
            
        }];
    }];
    
    
    return pickerDataView;

}


@end

