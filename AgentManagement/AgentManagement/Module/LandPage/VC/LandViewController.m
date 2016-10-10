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

@interface LandViewController ()
@property(nonatomic,strong)LandViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UILabel *tiltleLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bgViewTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property (weak, nonatomic) IBOutlet UITextField *inputUserName;
@property (weak, nonatomic) IBOutlet UITextField *inputPassWord;
@property (weak, nonatomic) IBOutlet UIButton *signinBtn;
@property (weak, nonatomic) IBOutlet UIImageView *recordPwdImage;
@property(nonatomic,assign)BOOL isNotRecordPwd;
@property (weak, nonatomic) IBOutlet UIControl *recordPwdControl;
@end

@implementation LandViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeContentViewPosition:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeContentViewPosition:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
    self.isNotRecordPwd=[[[NSUserDefaults standardUserDefaults]objectForKey:@"isNotRecordPwd"]boolValue];
    self.inputUserName.text = [[[NSUserDefaults standardUserDefaults]objectForKey:@"landInfo"]objectForKey:@"userName"];
    self.inputPassWord.text = [[[NSUserDefaults standardUserDefaults]objectForKey:@"landInfo"]objectForKey:@"password"];

    if (self.isNotRecordPwd) {//不记住密码

        self.inputPassWord.text = @"";
         self.recordPwdImage.image=[UIImage imageNamed:@"Rp1"];
        NSMutableDictionary*dic = [NSMutableDictionary dictionaryWithDictionary: [[NSUserDefaults standardUserDefaults]objectForKey:@"landInfo"]];
        [dic removeObjectForKey:@"password"];
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"landInfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else {//记住密码

         self.recordPwdImage.image=[UIImage imageNamed:@"Rp"];
        
        if ( self.inputUserName.text.length>0&&self.inputPassWord.text.length>0) {
            
            self.signinBtn.enabled = YES;
            self.signinBtn.backgroundColor = [UIColor colorWithHex:@"47b6ff"];
        }
        else {
            
            self.signinBtn.enabled = NO;
            self.signinBtn.backgroundColor = [UIColor colorWithHex:@"b3b3b3"];
        }
    }

    [[self.recordPwdControl rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIControl* x) {
       
        self.isNotRecordPwd = !self.isNotRecordPwd;

        self.recordPwdImage.image = self.isNotRecordPwd?[UIImage imageNamed:@"Rp1"]:[UIImage imageNamed:@"Rp"];

          [[NSUserDefaults standardUserDefaults]setObject:@(self.isNotRecordPwd) forKey:@"isNotRecordPwd"];
          [[NSUserDefaults standardUserDefaults]synchronize];
    }];
    
     [self racSignal];//信号相关
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];

}


#pragma mark - KeyboradNotification
- (void)changeContentViewPosition:(NSNotification *)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    

    [UIView animateWithDuration:duration.doubleValue delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
            
        self.bgViewTopConstraint.constant =keyBoardEndY==self.view.height?210:120;

        self.tiltleLabel.size = CGSizeMake(68, 19);

        self.titleLabelTopConstraint.constant = keyBoardEndY==self.view.height?117:29;

        self.tiltleLabel.text = keyBoardEndY==self.view.height?@"欢迎来到商库":@"登录商库";
            
        self.tiltleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: keyBoardEndY==self.view.height?36:17];
            
        self.tiltleLabel.textColor = keyBoardEndY==self.view.height?[UIColor colorWithHex:@"47b6ff"]:[UIColor colorWithHex:@"4a4a4a"];
            
    } completion:^(BOOL finished) {
            
    }];
}

#pragma mark -Signal
- (void)racSignal {
    
     RACSignal *validLenthUserNameSignal = [self.inputUserName.rac_textSignal map:^id(NSString* value) {
    
         if (value.length>11) {
             
             self.inputUserName.text = [value substringToIndex:11];
         }
         
         return @(value.length>0);

     }];

    //密码输入框是否有内容
    RACSignal *validLenthPasswordSignal = [self.inputPassWord.rac_textSignal map:^id(NSString* value) {
   
        if (value.length>12) {
            
            self.inputPassWord.text = [value substringToIndex:12];
        }
        
        return @(value.length>0);
    }];

    //账户输入框与密码输入框是否有内容
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validLenthUserNameSignal,validLenthPasswordSignal] reduce:^id(NSNumber *userNameLenthValid,NSNumber*passwordLenthValid){
        
        return @([userNameLenthValid boolValue] && [passwordLenthValid boolValue]);
    }];
    
    //根据俩个输入框是否都有内容——决定登录按钮是否可以点击
    RAC(self.signinBtn,enabled) = [signUpActiveSignal map:^id(NSNumber* value) {
        
        self.signinBtn.backgroundColor= [value boolValue]?[UIColor colorWithHex:@"47b6ff"]:[UIColor colorWithHex:@"b3b3b3"];
        
        return value;
    }];
    
    self.viewModel = [[LandViewModel alloc]init];
    
    [[self.signinBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        //登录请求
        [[[self.viewModel requestSigninWithUserName:self.inputUserName.text Password:self.inputPassWord.text]filter:^BOOL(id value) {
            
            if ([value isKindOfClass:[NSString class]]) {
                
                [MBProgressHUD showText:value];
                
                 return NO;
            }
            
            else {
                
                NSDictionary *dic = @{@"userName":self.inputUserName.text,@"password":self.inputPassWord.text};
                [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"landInfo"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                return YES;
            }
            
        }]subscribeNext:^(AMUser * x) {
   
            BaseTabbarController *rootVC=[[BaseTabbarController alloc]init];
          
            [self presentViewController:rootVC animated:YES completion:nil];

        }];
    }];

}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];

    return YES;
}

@end
