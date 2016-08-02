//
//  BaseViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/7/30.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomNavigationBar.h"
#import "UIView+KKFrame.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
@interface BaseViewController ()
@property(nonatomic,strong)CustomNavigationBar *navigationBar;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化导航栏
    [self initNavigationBar];
    // Do any additional setup after loading the view.
}


- (void)initNavigationBar {
    if (!_navigationBar) {
        _navigationBar = [CustomNavigationBar createViewFromXib];
        // 这句话必须加上，否则约束就有问题
       // _navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    }
    [self.view addSubview:_navigationBar];
    
    _navigationBar.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(64);
    
   // [self addConstraintsWithView:_navigationBar];
    if (self.navigationController) {
        if (self.navigationController.viewControllers[0] == self) {
            self.leftButton.hidden = YES;
        } else {
            self.leftButton.hidden = NO;
        }
    }
    // 默认左侧返回按钮
    [self.leftButton setImage:[UIImage imageNamed:@"YSBackBtn"] forState:UIControlStateNormal];
    [self.leftButton setTitle:@"" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    // 给左侧按钮添加默认事件
//    _navigationBar.leftBtnClickHandler = ^() {
//        __strong typeof(self) strongSelf = weakSelf;
//        [strongSelf defaultLeftBtnClick];
//    };
//    // 给右侧按钮添加默认事件
//    _navigationBar.rightBtnClickHandler = ^() {
//        __strong typeof(self) strongSelf = weakSelf;
//        [strongSelf defaultRightBtnClick];
//    };
}

#pragma mark 给自定义导航栏添加约束
//- (void)addConstraintsWithView:(UIView *)view {
//    // top
//    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
//    // left
//    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
//    // right
//    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
//    [self.view addConstraints:@[topConstraint, leftConstraint, rightConstraint]];
//    // height
//    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:view.bounds.size.height];
//    [view addConstraint:heightConstraint];
//}

#pragma mark 子类可以重写来实现不同的功能
- (void)defaultLeftBtnClick {
    NSAssert(self.navigationController, @"self.navigationController == nil");
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)defaultRightBtnClick {
    
}

@end
