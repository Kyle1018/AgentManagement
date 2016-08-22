//
//  CustomerDetailViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/18.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CustomerDetailViewController.h"
@interface CustomerDetailViewController ()

@property (strong, nonatomic) UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *editBGView;

@end

@implementation CustomerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.maskView = [[UIView alloc] initWithFrame:ScreenFrame];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideEditView)]];

}

- (void)hideEditView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.editBGView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.editBGView removeFromSuperview];
    }];
}

//调出编辑菜单
- (IBAction)editCutomerAction:(UIButton *)sender {
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.editBGView];
    self.maskView.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.editBGView.bottom = ScreenHeight-60;
    }];
}



@end
