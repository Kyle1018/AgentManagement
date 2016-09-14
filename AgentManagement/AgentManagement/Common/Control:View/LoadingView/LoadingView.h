//
//  LoadingView.h
//  AgentManagement
//
//  Created by huabin on 16/9/14.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapRefreshButtonBlcok)();

@interface LoadingView : UIView

@property(nonatomic,copy)TapRefreshButtonBlcok tapRefreshButtonBlcok;

+(void)showLoadingAddToView:(UIView*)view; //显示loading页面，默认显示文字为"内容获取中..."

+ (LoadingView*)showRetryAddToView:(UIView*)view;

+ (void)hideLoadingViewRemoveView:(UIView*)view;

+ (void)showNoDataAddToView:(UIView*)view;
//-(void)ShowRetry;   //显示重试页面，默认显示文字为""加载失败，点击这里重新试试""


@end
