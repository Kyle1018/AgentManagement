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
#import "AMRegister.h"
#import "LandViewController.h"
@interface SetPasswordViewController()

@property (weak, nonatomic) IBOutlet UITextField *inputPassword;

@property (weak, nonatomic) IBOutlet UITextField *againInputPassword;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property(nonatomic,strong)LandViewModel *viewModel;

@end
@implementation SetPasswordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSLog(@"%@",self.registerInformationDic);
    
    _viewModel = [[LandViewModel alloc]init];
     __weak typeof(self) weakSelf = self;
    __block NSString *password = @"";
    __block NSString *againPassword = @"";
    
    //手机号输入框是否有内容
    RACSignal *validLenthPasswordSignal = [self.inputPassword.rac_textSignal map:^id(NSString* value) {
        
        password = value;
        return @(value.length>0);
        
    }];
    
    //验证码输入框是否有内容
    RACSignal *validLenthAgainPasswordSignal = [self.againInputPassword.rac_textSignal map:^id(NSString* value) {
        
        againPassword = value;
        return @(value.length>0);
        
    }];
    
    //验证码输入框与手机号码输入框是否有内容
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validLenthPasswordSignal,validLenthAgainPasswordSignal] reduce:^id(NSNumber *passwordLenthValid,NSNumber*againPasswordLenthValid){
        
        return @([passwordLenthValid boolValue] && [againPasswordLenthValid boolValue]);
    }];
    
    
    //根据俩个输入框是否都有内容——决定下一步按钮是否可以点击
    RAC(self.finishBtn,enabled) = [signUpActiveSignal map:^id(NSNumber* value) {
        
        return value;
    }];
    
    //根据俩个输入框是否都有内容——决定下一步按钮的文字颜色
    RAC(self.finishBtn,backgroundColor) = [signUpActiveSignal map:^id(NSNumber* value) {
        
        return [value boolValue]?[UIColor colorWithHex:@"47b6ff"]:[UIColor colorWithHex:@"b3b3b3"];
    }];
    
    
    [[[self.finishBtn rac_signalForControlEvents:UIControlEventTouchUpInside]filter:^BOOL(id value) {
        
        if (![password isEqualToString:againPassword]) {
            
            [MBProgressHUD showText:@"两次密码输入不同"];
            
            return NO;
        }
        else {
            
            
            if ([RegexUtils checkPassword:password]) {
                
                [self.registerInformationDic setObject:password forKey:@"password"];
                
                return YES;
                
            }
            
            else {
                
                [MBProgressHUD showText:@"请输入6-12字符，包含数字、大写字母、小写字母"];
                
                return NO;
            }
        }
        
        
    }]subscribeNext:^(id x) {
        
     
        //注册请求
        [[[weakSelf.viewModel requestRegisterWithRegisterInformation:weakSelf.registerInformationDic]filter:^BOOL(id value) {
           
            if ([value isKindOfClass:[AMRegister class]]) {
                
                [MBProgressHUD showText:@"注册成功"];

                return YES;
            }
            else {
               
                [MBProgressHUD showText:value];
                
                return NO;
            }
            
           
        }]subscribeNext:^(AMRegister* x) {
            
         
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
               
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[LandViewController class]]) {
                        
                        LandViewController *vc = (LandViewController*)controller;
                        
                        vc.registerModel = x;
                        
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }

            });
            
           
        }];
        
    }];
    
}
- (void)popToRootVC:(AMRegister*)x {
    

    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
     //[self.navigationController popToRootViewControllerAnimated:YES];
}

@end
