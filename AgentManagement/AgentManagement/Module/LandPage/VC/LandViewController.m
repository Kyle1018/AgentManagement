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
@property(nonatomic,assign)BOOL recordPwd;
@property (weak, nonatomic) IBOutlet UIControl *recordPwdControl;
@end

@implementation LandViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self racSignal];//信号相关
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeContentViewPosition:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeContentViewPosition:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    

    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"pp"]boolValue]) {
        
         self.recordPwdImage.image=[UIImage imageNamed:@"Rp1"];
        self.inputUserName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
        self.inputPassWord.text = @"";
    }
    else {
        
         self.recordPwdImage.image=[UIImage imageNamed:@"Rp"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]);
         self.inputUserName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
         self.inputPassWord.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    }
    

    RACSignal*signal=[[self.recordPwdControl rac_signalForControlEvents:UIControlEventTouchUpInside]map:^id(UIControl* value) {
       
        value.selected = ![[[NSUserDefaults standardUserDefaults]objectForKey:@"pp"]boolValue];
        [[NSUserDefaults standardUserDefaults]setObject:@(value.selected) forKey:@"pp"];
        [[NSUserDefaults standardUserDefaults]synchronize];
 
        return @(value.selected);
    }];
    
    RAC(self.recordPwdImage,image) = [signal map:^id(NSNumber* value) {

        return [value boolValue]?[UIImage imageNamed:@"Rp1"]:[UIImage imageNamed:@"Rp"];
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    
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
    
    _viewModel = [[LandViewModel alloc]init];

     RACSignal *validLenthUserNameSignal = [self.inputUserName.rac_textSignal map:^id(NSString* value) {
  
         return @(value.length>0);
     }];

    //密码输入框是否有内容
    RACSignal *validLenthPasswordSignal = [self.inputPassWord.rac_textSignal map:^id(NSString* value) {
   
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
    
    __block NSString *userName =@"";//用户名
    __block NSString*password = @"";//密码
    
    @weakify(self);
    [[self.inputUserName.rac_textSignal filter:^BOOL(NSString* value) {
        
        @strongify(self);
        
        if (value.length>11) {
            
            self.inputUserName.text = [value substringToIndex:11];
            
            return NO;
        }
        else if (value.length==0) {
            
            return NO;
        }
        else {
            
            return YES;
        }
        
    }]subscribeNext:^(id x) {
        
         userName = x;
        
        [[NSUserDefaults standardUserDefaults]setObject:userName forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
    
    [[self.inputPassWord.rac_textSignal filter:^BOOL(NSString* value) {
        
        @strongify(self);
        
        if (value.length>12) {
            
            self.inputPassWord.text = [value substringToIndex:12];
            
            return NO;
        }
        else if (value.length == 0) {
            
            return NO;
        }
        else {
            
            return YES;
        }
        
    }]subscribeNext:^(id x) {
        
         password = x;
        
        [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];

    
    [[self.signinBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        //登录请求
        [[[self.viewModel requestSigninWithUserName:userName Password:password]filter:^BOOL(id value) {
            
            if ([value isKindOfClass:[NSString class]]) {
                
                [MBProgressHUD showText:value];
                
                 return NO;
            }
            
            else {
                
                return YES;
            }
            
        }]subscribeNext:^(AMUser * x) {
            
            //如果选择了“记住密码”则在此保存用户名和密码
            
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
