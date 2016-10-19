//
//  AMModifyPasswordViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMModifyPasswordViewController.h"
#import "AMUserViewModel.h"

@interface AMModifyPasswordViewController ()

@property (nonatomic, weak) IBOutlet UITextField *currentPasswordTextField;
@property (nonatomic, weak) IBOutlet UITextField *inputPasswordTextField;
@property (nonatomic, weak) IBOutlet UITextField *confirmPasswordTextField;
@property (nonatomic, weak) IBOutlet UIButton *confirmButton;

@property (nonatomic, strong) AMUserViewModel *userViewModel;

@end

@implementation AMModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializeControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AMUserViewModel *)userViewModel {
    if (!_userViewModel) {
        _userViewModel = [[AMUserViewModel alloc] init];
    }
    return _userViewModel;
}

- (void)initializeControl {
    self.title = @"修改密码";
    
    self.confirmButton.layer.masksToBounds = YES;
    self.confirmButton.layer.cornerRadius = 4.;
    [self.confirmButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"47b6ff"]] forState:UIControlStateNormal];
    
    RAC(self.confirmButton, enabled) = [RACSignal combineLatest:@[self.currentPasswordTextField.rac_textSignal, self.inputPasswordTextField.rac_textSignal, self.confirmPasswordTextField.rac_textSignal] reduce:^id(NSString *currentPassword, NSString *inputPassword, NSString *confirmPassword) {
        return @((currentPassword.length > 0) && (inputPassword.length > 0) && (confirmPassword.length > 0));
    }];
    
    @weakify(self);
    [[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [MBProgressHUD showText:@"正在处理中..."];
        [[self.userViewModel modifyPasswordSignalWithCurrentPassword:self.currentPasswordTextField.text inputPassword:self.inputPasswordTextField.text confirmPassword:self.confirmPasswordTextField.text] subscribeError:^(NSError *error) {
        } completed:^{
        }];
    }];
}

@end
