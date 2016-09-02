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
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bgViewbottomConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;

@end

@implementation LandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [self notificationRelevant];//通知相关
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];

}

#pragma mark - NSNotificationCenter
- (void)notificationRelevant {

//    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardWillShowNotification object:nil]subscribeNext:^(id x) {
//        
//        __weak typeof(self) weakSelf = self;
//        
//        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
//            
//            weakSelf.bgView.originY = 120;
//            weakSelf.tiltleLabel.originY = 29;
//            weakSelf.bgViewTopConstraint.constant = self.bgView.originY;
//            weakSelf.titleLabelTopConstraint.constant = self.tiltleLabel.originY;
//            weakSelf.tiltleLabel.text = @"";
//            weakSelf.tiltleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"size:17];
//            weakSelf.tiltleLabel.textColor = [UIColor colorWithHex:@"4a4a4a"];
//            weakSelf.tiltleLabel.text = @"登陆商库";
//            
//        } completion:^(BOOL finished) {
//            
//            [weakSelf.view setNeedsLayout]; //更新视图
//            [weakSelf.view layoutIfNeeded];
//            
//            
//        }];
//
//    }];
//    
//    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardWillHideNotification object:nil]subscribeNext:^(id x) {
//        
//        NSLog(@"键盘收回");
//        
//    
//    }];
//    
    
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
    
    NSLog(@"____________%f",keyBoardEndY);
   // NSLog(@"%f",);
    
    [UIView animateWithDuration:duration.doubleValue delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        
        weakSelf.bgView.bottom = keyBoardEndY==self.view.height?keyBoardEndY-276:keyBoardEndY-151;
        weakSelf.bgViewbottomConstraint.constant =keyBoardEndY==self.view.height?276:367;//修改距离底部的约束
      //  weakSelf.titleLabelTopConstraint.constant = weakSelf.tiltleLabel.bottom-weakSelf.tiltleLabel.height;
        weakSelf.tiltleLabel.text = @"";
        weakSelf.tiltleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"size:36];
        weakSelf.tiltleLabel.textColor = [UIColor colorWithHex:@"47b6ff"];
        weakSelf.tiltleLabel.text = @"欢迎来到商库";

        
    } completion:^(BOOL finished) {
        
    }];
    
    
//    [UIView animateWithDuration:duration.doubleValue animations:^{
//        
////        [UIView setAnimationBeginsFromCurrentState:YES];
////        [UIView setAnimationCurve:[curve intValue]];
//        
//        weakSelf.bgView.bottom = keyBoardEndY-151.0;
//        weakSelf.tiltleLabel.bottom = keyBoardEndY-403;
////        weakSelf.bgViewTopConstraint.constant = weakSelf.bgView.originY;//修改距离底部的约束
////        weakSelf.titleLabelTopConstraint.constant = weakSelf.tiltleLabel.originY;
//        weakSelf.tiltleLabel.text = @"";
//        weakSelf.tiltleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"size:36];
//        weakSelf.tiltleLabel.textColor = [UIColor colorWithHex:@"47b6ff"];
//        weakSelf.tiltleLabel.text = @"欢迎来到商库";
//        
//    } completion:^(BOOL finished) {
//        
//        [weakSelf.view setNeedsLayout]; //更新视图
//        [weakSelf.view layoutIfNeeded];
//
//    }];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    


    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
//
//    __weak typeof(self) weakSelf = self;
//    
//    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
//        
//        weakSelf.bgView.originY = 210;
//        weakSelf.tiltleLabel.originY = 117;
//        weakSelf.bgViewTopConstraint.constant = weakSelf.bgView.originY;//修改距离底部的约束
//        weakSelf.titleLabelTopConstraint.constant = weakSelf.tiltleLabel.originY;
//        weakSelf.tiltleLabel.text = @"";
//        weakSelf.tiltleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"size:36];
//        weakSelf.tiltleLabel.textColor = [UIColor colorWithHex:@"47b6ff"];
//        weakSelf.tiltleLabel.text = @"欢迎来到商库";
//        
//    } completion:^(BOOL finished) {
//        
        [textField resignFirstResponder];
//        
//        [weakSelf.view setNeedsLayout]; //更新视图
//        [weakSelf.view layoutIfNeeded];
//        
//    }];

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
