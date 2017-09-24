//
//  SetPasswordViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "RegexUtils.h"
#import "LandViewModel.h"
#import "AMUser.h"
#import "RegisterDetailViewController.h"

#define FORGETPASSWORD_PAGE [self.title isEqualToString:@"忘记密码"]

@interface SetPasswordViewController()

@property (weak, nonatomic) IBOutlet UITextField *inputPassword;

@property (weak, nonatomic) IBOutlet UITextField *againInputPassword;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property(nonatomic,strong)LandViewModel *viewModel;

@end
@implementation SetPasswordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (FORGETPASSWORD_PAGE) {
        
        [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    
    NSLog(@"%@",_registerInformationDic);
    
    _viewModel = [[LandViewModel alloc]init];

    __block NSString *password = @"";
    __block NSString *againPassword = @"";
    
    //密码输入框是否有内容
    RACSignal *validLenthPasswordSignal = [self.inputPassword.rac_textSignal map:^id(NSString* value) {
        
        password = value;
        return @(value.length>0);
        
    }];
    
    //再次输入密码框是否有内容
    RACSignal *validLenthAgainPasswordSignal = [self.againInputPassword.rac_textSignal map:^id(NSString* value) {
        
        againPassword = value;
        return @(value.length>0);
        
    }];
    
    //验证码输入框与手机号码输入框是否有内容
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validLenthPasswordSignal,validLenthAgainPasswordSignal] reduce:^id(NSNumber *passwordLenthValid,NSNumber*againPasswordLenthValid){
        
        return @([passwordLenthValid boolValue] && [againPasswordLenthValid boolValue]);
    }];
    
    
    @weakify(self);
    //根据俩个输入框是否都有内容——决定下一步按钮是否可以点击
    RAC(self.finishBtn,enabled) = [signUpActiveSignal map:^id(NSNumber* value) {
        
        @strongify(self);
        
        self.finishBtn.backgroundColor = [value boolValue]?[UIColor colorWithHex:@"47b6ff"]:[UIColor colorWithHex:@"b3b3b3"];
        
        return value;
    }];
    
    
    //完成按钮点击事件
    [[[self.finishBtn rac_signalForControlEvents:UIControlEventTouchUpInside]filter:^BOOL(id value) {
        
        @strongify(self);
        
        if (![password isEqualToString:againPassword]) {
            
            [MBProgressHUD showText:@"两次密码输入不同"];
            
            return NO;
        }
        else {
            
            
            if ([RegexUtils checkPassword:password]) {
                
                [self.registerInformationDic setObject:password forKey:@"new_password"];
                [self.registerInformationDic setObject:password forKey:@"re_password"];
                return YES;
                
            }
            
            else {
            
                [MBProgressHUD showText:@"请输入6-12字符，包含数字、大写字母、小写字母"];
                
                return NO;
            }
        }
        
        
    }]subscribeNext:^(id x) {
        
        @strongify(self);
        
        if (FORGETPASSWORD_PAGE) {
            
            //找回密码
            [[self.viewModel requestBackPasswordWithLandInformation:self.registerInformationDic]subscribeNext:^(NSString* x) {
                
                if ([x isEqualToString:@"OK"]) {
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else {
                    
                    [MBProgressHUD showText:x];
                }
                
            }];
        
        }
        else {
            
            //注册
            [[self.viewModel requestRegisterWithRegisterInformation:self.registerInformationDic]subscribeNext:^(NSString* x) {
                AMBaseModel *model = (AMBaseModel *)x;
                
                if ([model isValid]) {
                    //注册完成后，进入企业详情页面
                    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Land" bundle:nil];
                    RegisterDetailViewController*registerDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"RegisterDetail"];
                    [self.navigationController pushViewController:registerDetailVC animated:YES];
                    
                } else {
                    [MBProgressHUD showText:x];
                }
            }];
 
        }

    }];
}

@end
