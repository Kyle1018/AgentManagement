//
//  LandViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "LandViewController.h"
#import "BaseTabbarController.h"
#import "LandViewModel.h"
#import "AMUser.h"
#import "Reachability.h"
@interface LandViewController ()

@property(nonatomic,strong)LandViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *tiltleLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bgViewTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property (weak, nonatomic) IBOutlet UITextField *inputUserName;
@property (weak, nonatomic) IBOutlet UITextField *inputPassWord;
@property (weak, nonatomic) IBOutlet UIButton *signinBtn;
@property(nonatomic,assign)CGFloat bgViewTop;
@property(nonatomic,assign)CGFloat titleLabelTop;
@end

@implementation LandViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

   [self keyboradNotification];//通知相关
    
    [self racSignal];//信号相关
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

#pragma mark -Signal
- (void)racSignal {
    
    _viewModel = [[LandViewModel alloc]init];
    __weak typeof(self) weakSelf = self;
    __block NSString *userName =@"";//用户名
    __block NSString*password = @"";//密码
    
     RACSignal *validLenthUserNameSignal = [self.inputUserName.rac_textSignal map:^id(NSString* value) {
         
         userName = value;
         return @(value.length>0);
     }];

    
    //密码输入框是否有内容
    RACSignal *validLenthPasswordSignal = [self.inputPassWord.rac_textSignal map:^id(NSString* value) {
        
        password = value;
        return @(value.length>0);
    }];

    //账户输入框与密码输入框是否有内容
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validLenthUserNameSignal,validLenthPasswordSignal] reduce:^id(NSNumber *userNameLenthValid,NSNumber*passwordLenthValid){
        
        return @([userNameLenthValid boolValue] && [passwordLenthValid boolValue]);
    }];
    
    //根据俩个输入框是否都有内容——决定登录按钮是否可以点击
    RAC(self.signinBtn,enabled) = [signUpActiveSignal map:^id(NSNumber* value) {
        
        return value;
    }];
    
    //根据俩个输入框是否都有内容——决定登录按钮的文字颜色
    RAC(self.signinBtn,backgroundColor) = [signUpActiveSignal map:^id(NSNumber* value) {
        
        return [value boolValue]?[UIColor colorWithHex:@"47b6ff"]:[UIColor colorWithHex:@"b3b3b3"];
    }];
    
    
    [[self.signinBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        //登录请求
        [[[weakSelf.viewModel requestSigninWithUserName:userName Password:password]filter:^BOOL(id value) {
            
            if ([value isKindOfClass:[NSString class]]) {
                
                [MBProgressHUD showText:value];
                
                 return NO;
            }
            
            else {
                
                return YES;
            }
            
        }]subscribeNext:^(AMUser * x) {
            
            BaseTabbarController *rootVC=[[BaseTabbarController alloc]init];
          
            [self presentViewController:rootVC animated:YES completion:^{
                
            }];

        }];
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

#pragma mark Action
- (IBAction)textFieldDidChange:(UITextField *)sender {
    
    if (sender == self.inputUserName) {
        if (sender.text.length > 11) {
            sender.text = [sender.text substringToIndex:11];
        }
    }
    
    else if (sender == self.inputPassWord) {
        
        if (sender.text.length > 12) {
            sender.text = [sender.text substringToIndex:12];
        }
    }
}

@end
