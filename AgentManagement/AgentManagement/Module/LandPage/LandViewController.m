//
//  LandViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "LandViewController.h"
#import "BaseTabbarController.h"
@interface LandViewController ()

@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) IBOutlet UILabel *tiltleLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bgViewTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property(nonatomic,assign)CGFloat bgViewTop;
@property(nonatomic,assign)CGFloat titleLabelTop;
@end

@implementation LandViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
   [self keyboradNotification];//通知相关
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];

}

#pragma mark - KeyboradNotification
- (void)keyboradNotification {

    _bgViewTop = self.bgViewTopConstraint.constant;
    
    _titleLabelTop = self.titleLabelTopConstraint.constant;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeContentViewPosition:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeContentViewPosition:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
}

- (void) changeContentViewPosition:(NSNotification *)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:duration.doubleValue delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        
        weakSelf.bgViewTopConstraint.constant =keyBoardEndY==self.view.height?weakSelf.bgViewTop:120;
        
        weakSelf.bgView.originY = weakSelf.bgViewTopConstraint.constant;
        
        weakSelf.tiltleLabel.width  = 68;
        weakSelf.tiltleLabel.height = 19;
        
        weakSelf.titleLabelTopConstraint.constant = keyBoardEndY==self.view.height?weakSelf.titleLabelTop:29;
        
        weakSelf.tiltleLabel.originY = weakSelf.titleLabelTopConstraint.constant;
        
        weakSelf.tiltleLabel.text = keyBoardEndY==self.view.height?@"欢迎来到商库":@"登录商库";

        weakSelf.tiltleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: keyBoardEndY==self.view.height?36:17];
        
        weakSelf.tiltleLabel.textColor = keyBoardEndY==self.view.height?[UIColor colorWithHex:@"47b6ff"]:[UIColor colorWithHex:@"4a4a4a"];
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];

    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LandSuccessAction:(id)sender {
    
    BaseTabbarController *tabbar = [[BaseTabbarController alloc]init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
}

@end
