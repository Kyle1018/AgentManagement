//
//  IdentifyCodeButton.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "IdentifyCodeButton.h"
#import "TimerCountDownManager.h"
@interface IdentifyCodeButton()

@property (nonatomic, strong) UILabel *overlayLabel;

@end

@implementation IdentifyCodeButton


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    
    return self;
}

//初始化
- (void)initialize {
    
    //获取key
    self.identifyKey        = NSStringFromClass([self class]);
    self.clipsToBounds      = YES;
    self.layer.cornerRadius = 4;
    //添加显示倒计时的label
    [self addSubview:self.overlayLabel];
}

- (UILabel *)overlayLabel {
    
    //默认为隐藏
    if (!_overlayLabel) {
        _overlayLabel                 = [UILabel new];
        _overlayLabel.textColor       = self.titleLabel.textColor;
        _overlayLabel.backgroundColor = self.backgroundColor;
        _overlayLabel.font            = self.titleLabel.font;
        _overlayLabel.textAlignment   = NSTextAlignmentCenter;
        _overlayLabel.hidden          = YES;
    }
    
    return _overlayLabel;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.overlayLabel.frame = self.bounds;
    
    //根据key判断倒计时任务是否存在——首次进入没有倒计时任务
    if ([[TimerCountDownManager defaultManager] countdownTaskExistWithKey:self.identifyKey task:nil]) {
        [self shouldCountDown];
    }
}


- (void)shouldCountDown {
    
    //显示倒计时label，隐藏button相关
    self.enabled             = NO;
    self.titleLabel.alpha    = 0;
    self.overlayLabel.hidden = NO;
  
    self.overlayLabel.text   = self.titleLabel.text;
    [self.overlayLabel setBackgroundColor:self.disabledBackgroundColor ?: self.backgroundColor];
    [self.overlayLabel setTextColor:self.disabledTitleColor ?: self.titleLabel.textColor];
    
    
    __weak __typeof(self) weakSelf = self;
    
    [[TimerCountDownManager defaultManager] scheduledCountDownWithKey:self.identifyKey timeInterval:60 countingDown:^(NSTimeInterval leftTimeInterval) {
        __strong __typeof(weakSelf) self = weakSelf;
        self.overlayLabel.text = [NSString stringWithFormat:@"%@ 秒后重试", @(leftTimeInterval)];
    } finished:^(NSTimeInterval finalTimeInterval) {
        __strong __typeof(weakSelf) self = weakSelf;
        self.enabled             = YES;
        self.overlayLabel.hidden = YES;
        self.titleLabel.alpha    = 1;
        [self.overlayLabel setBackgroundColor:self.backgroundColor];
        [self.overlayLabel setTextColor:self.titleLabel.textColor];
    }];
}

//点击了获取验证码按钮事件
- (void)start {
    
    [self shouldCountDown];

}

@end
