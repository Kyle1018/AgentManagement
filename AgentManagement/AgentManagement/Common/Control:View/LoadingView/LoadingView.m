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

+(void)ShowLoadingAddToView:(UIView*)view{
    
    for (UIView *subView in view.subviews) {
        
        if ([subView isKindOfClass:[LoadingView class]]) {
            
            [subView removeFromSuperview];
        }
    }
    
    
    LoadingView *loadingView = [[LoadingView alloc]initWithFrame:view.bounds];

    [view addSubview:loadingView];
    
    [loadingView ShowLoadingMessage:@"内容获取中..."];
    
    
}//显示loading页面，默认显示文字为"内容获取中..."


+ (LoadingView*)ShowRetryAddToView:(UIView*)view {
    
    for (UIView *subView in view.subviews) {
        
        if ([subView isKindOfClass:[LoadingView class]]) {
            
            [subView removeFromSuperview];
        }
    }
    
    LoadingView *loadingView = [[LoadingView alloc]initWithFrame:view.bounds];
    
    [view addSubview:loadingView];
    
    [loadingView ShowRetryMessage:@"加载失败，点击这里重新试试"];
 
    return loadingView;
}

+ (void)hideLoadingViewRemoveView:(UIView*)view {
    
    for (UIView *subView in view.subviews) {
        
        if ([subView isKindOfClass:[LoadingView class]]) {
            
            [subView removeFromSuperview];
        }
    }

}
//-(void)ShowRetry{
//    
//     [self ShowRetryMessage:@"加载失败，点击这里重新试试"];
//}//显示重试页面，默认显示文字为""加载失败，点击这里重新试试""

-(void)ShowRetryMessage:(NSString *)message {
    
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

-(void)ShowLoadingMessage:(NSString *)message
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
