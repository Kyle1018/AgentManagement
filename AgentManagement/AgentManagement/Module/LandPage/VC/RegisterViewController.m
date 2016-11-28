//
//  RegisterViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegexUtils.h"
#import "LandViewModel.h"
#import "IdentifyCodeButton.h"
#import "SetPasswordViewController.h"
@interface RegisterViewController ()
@property(nonatomic,strong)LandViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *inputPhone;
@property (weak, nonatomic) IBOutlet UITextField *inputIdentifyCode;
@property (weak, nonatomic) IBOutlet UITextField *inputRegisterName;
@property (weak, nonatomic) IBOutlet IdentifyCodeButton *identifyCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _viewModel = [[LandViewModel alloc]init];
  
    __block NSString *phoneText = @"";//手机号
    __block NSString *inputIdentifyCodeText = @"";//输入的验证码
    __block NSString *requestIdentifyCode = @"";//请求获得的验证码
    __block NSMutableDictionary *registerInformationDic = [NSMutableDictionary dictionary];
 
    //手机号输入框是否有内容
    RACSignal *validLenthPhoneSignal = [self.inputPhone.rac_textSignal map:^id(NSString* value) {
        
        phoneText = value;
        return @(value.length>0);
        
    }];
    
    //根据手机输入框是否有内容——决定获取验证码按钮是否可以点击
    RAC(self.identifyCodeBtn,enabled) =  [validLenthPhoneSignal map:^id(NSNumber* phoneValid) {
        
        [self.identifyCodeBtn setTitleColor:[phoneValid boolValue]?[UIColor colorWithHex:@"47b6ff"]:[UIColor colorWithHex:@"b3b3b3"] forState:UIControlStateNormal];
        
        return @([phoneValid boolValue]);
    }];
    
    //验证码输入框是否有内容
    RACSignal *validLenthIdentifyCodeSignal = [self.inputIdentifyCode.rac_textSignal map:^id(NSString* value) {
        
        inputIdentifyCodeText = value;
        return @(value.length>0);
        
    }];
    
    
    //工商注册名称是否有内容
    RACSignal *validLenthRegisterNameSignal = [self.inputRegisterName.rac_textSignal map:^id(NSString * value) {
        
        return @(value.length>0);
        
    }];

    //验证码输入框与手机号码输入框是否有内容
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validLenthPhoneSignal,validLenthIdentifyCodeSignal,validLenthRegisterNameSignal] reduce:^id(NSNumber *phoneLenthValid,NSNumber*identifyCodeLenthValid,NSNumber*registerNameLenthValid){
        
        return @([phoneLenthValid boolValue] && [identifyCodeLenthValid boolValue] && [registerNameLenthValid boolValue]);
    }];
    
    //根据俩个输入框是否都有内容——决定下一步按钮是否可以点击
    RAC(self.nextBtn,enabled) = [signUpActiveSignal map:^id(NSNumber* value) {
        
        self.nextBtn.backgroundColor = [value boolValue]?[UIColor colorWithHex:@"47b6ff"]:[UIColor colorWithHex:@"b3b3b3"];
        
        return value;
    }];
    
    
    //获取验证码按钮点击事件
    @weakify(self);
    [[[self.identifyCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]filter:^BOOL(IdentifyCodeButton* sender) {
  
        @strongify(self);
        //请求判断手机号是否注册过接口
        [[self.viewModel requestPhoneNumRegisterState:phoneText]subscribeNext:^(id x) {
            
            NSLog(@"%@",x);
        }];
        
        
        if ([RegexUtils checkTelNumber:phoneText]) {
            
            return YES;
        }
        else {
          
            [MBProgressHUD showText:@"手机号格式错误"];
            
            return NO;
        }
        
    }]subscribeNext:^(IdentifyCodeButton* sender) {
        
        @strongify(self);
        //请求验证码
      [[[self.viewModel requestIdentifyCode:phoneText]filter:^BOOL(id value) {

           if ([value isKindOfClass:[NSString class]]) {
               
               [MBProgressHUD showText:value];
               return NO;
           }
           else {
               [sender start];
               
               return YES;
           }
           
        }]subscribeNext:^(RACTuple* x) {
            
            requestIdentifyCode = [x first];
            
#warning 测试阶段使用
            self.inputIdentifyCode.text = requestIdentifyCode;
            [registerInformationDic setValue:phoneText forKey:@"phone"];
            [registerInformationDic setValue:requestIdentifyCode forKey:@"identifyCode"];

        }];
    }];

    //下一步按钮点击事件
   [[[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside]filter:^BOOL(id value) {
       
       //手机号合法 并且 验证码输入正确
        if ([RegexUtils checkTelNumber:phoneText] && [inputIdentifyCodeText isEqualToString:requestIdentifyCode]) {
            
            return YES;
        }
        else if (![RegexUtils checkTelNumber:phoneText] && [inputIdentifyCodeText isEqualToString:requestIdentifyCode]) {
            
            [MBProgressHUD showText:@"手机号格式错误"];
            return NO;

        }
        else if ([RegexUtils checkTelNumber:phoneText] && ![inputIdentifyCodeText isEqualToString:requestIdentifyCode]) {
            
             [MBProgressHUD showText:@"验证码错误"];
            return NO;
        }
        else {
            
            [MBProgressHUD showText:@"手机号格式或验证码错误"];
            return NO;
        }
       
    }]subscribeNext:^(id x) {
        @strongify(self);
        //进入设置密码页面
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Land" bundle:nil];
        SetPasswordViewController*setPasswordVC = [storyboard instantiateViewControllerWithIdentifier:@"SetPsswordId"];
        setPasswordVC.registerInformationDic = registerInformationDic;
        setPasswordVC.title = @"设置密码";
        [self.navigationController pushViewController:setPasswordVC animated:YES];
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
