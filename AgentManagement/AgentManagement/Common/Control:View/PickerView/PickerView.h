//
//  PickerView.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/10.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapConfirmBlock)();

@interface PickerView : UIView
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIView *pickerBGView;
@property(nonatomic,copy)TapConfirmBlock tapConfirmBlock;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

+ (PickerView*)showAddTo:(UIView*)view;
@end
