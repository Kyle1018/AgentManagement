//
//  LoadingView.m
//  AgentManagement
//
//  Created by huabin on 16/9/14.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "LoadingView.h"
@interface LoadingView()
@property (nonatomic, strong) UIButton * refreshButton;
@property (nonatomic, readonly) UILabel *tipLabel;
@end
@implementation LoadingView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.size = CGSizeMake(self.frame.size.width-30,  60);
        _tipLabel.center = self.center;
        _tipLabel.userInteractionEnabled = NO;
        _tipLabel.numberOfLines = 0;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _tipLabel.textColor = [UIColor colorWithHex:@"797979"];
        _tipLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_tipLabel];
    }
    
    return self;
}

+(void)showLoadingAddToView:(UIView*)view{
    
    for (UIView *subView in view.subviews) {
        
        if ([subView isKindOfClass:[LoadingView class]]) {
            
            [subView removeFromSuperview];
        }
    }
    
    
    LoadingView *loadingView = [[LoadingView alloc]initWithFrame:view.bounds];

    [view addSubview:loadingView];
    
    [loadingView showLoadingMessage:@"内容获取中..."];
    
    
}//显示loading页面，默认显示文字为"内容获取中..."

+(void)showLoadingAddToView:(UIView*)view message:(NSString*)text {
    
    for (UIView *subView in view.subviews) {
        
        if ([subView isKindOfClass:[LoadingView class]]) {
            
            [subView removeFromSuperview];
        }
    }
    
    
    LoadingView *loadingView = [[LoadingView alloc]initWithFrame:view.bounds];
    
    [view addSubview:loadingView];
    
    [loadingView showLoadingMessage:text];
}

+ (LoadingView*)showRetryAddToView:(UIView*)view {
    
    for (UIView *subView in view.subviews) {
        
        if ([subView isKindOfClass:[LoadingView class]]) {
            
            [subView removeFromSuperview];
        }
    }
    
    LoadingView *loadingView = [[LoadingView alloc]initWithFrame:view.bounds];
    
    [view addSubview:loadingView];
    
    [loadingView showRetryMessage:@"加载失败，点击这里重新试试"];
 
    return loadingView;
}

+ (void)hideLoadingViewRemoveView:(UIView*)view {
    
    for (UIView *subView in view.subviews) {
        
        if ([subView isKindOfClass:[LoadingView class]]) {
            
            [subView removeFromSuperview];
        }
    }

}

+ (void)showNoDataAddToView:(UIView*)view {
    
    for (UIView *subView in view.subviews) {
        
        if ([subView isKindOfClass:[LoadingView class]]) {
            
            [subView removeFromSuperview];
        }
    }
    
    LoadingView *loadingView = [[LoadingView alloc]initWithFrame:view.bounds];
    
    [view addSubview:loadingView];
    
    [loadingView showLoadingMessage:@"无内容"];
    
}

-(void)showRetryMessage:(NSString *)message {
    
    _tipLabel.text = message;
    if (!_refreshButton) {
        _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.refreshButton.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
        self.refreshButton.frame = self.bounds;
        [self.refreshButton addTarget:self action:@selector(refreshButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:self.refreshButton];
    //[self startLoading];
}

-(void)showLoadingMessage:(NSString *)message
{
    if (self.refreshButton) {
        [self.refreshButton removeFromSuperview];
    }
     _tipLabel.text = message;
}

- (void)refreshButtonPressed {
    
    if (self.tapRefreshButtonBlcok) {
        
        self.tapRefreshButtonBlcok();
    }
}

@end
