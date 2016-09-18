//
//  CustomerDetailViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/18.
//  Copyright © 2016年 KK. All rights reserved.

#import "CustomerDetailViewController.h"
#import "AlertController.h"

@interface CustomerDetailViewController ()

@property(nonatomic,strong)AlertController *alertVC;

@property(nonatomic,strong)UIView *maskView;

@end

@implementation CustomerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     [self createMaskView];
}

- (void)createMaskView {
    
    self.maskView = [[UIView alloc] initWithFrame:ScreenFrame];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
}

- (void)hideMyPicker {
    
    UITextField *cutomerNameTextField = [self.tableView viewWithTag:1000];
    
    UITextField*phoneNumberTextField = [self.view viewWithTag:1001];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if ([cutomerNameTextField isFirstResponder]) {
            
            [cutomerNameTextField resignFirstResponder];
        }
        else if ([phoneNumberTextField isFirstResponder]) {
            
            [phoneNumberTextField resignFirstResponder];
        }
        self.maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.maskView removeFromSuperview];
        
    }];
}

#pragma mark - Action
//编辑菜单
- (IBAction)editCutomerAction:(UIButton *)sender {
    
    
    self.alertVC = [AlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    self.alertVC.actionButtonArray = @[@"编辑客户",@"删除客户"];
    
    __weak typeof(self) weakSelf = self;
    
    self.alertVC.tapActionButtonBlock = ^(NSInteger alertTag,NSString* keyName,NSInteger index) {
        
        if (index == 0) {
            
            DDLogDebug(@"点击了编辑客户");
            UITextField *customerName=[weakSelf.tableView viewWithTag:1000];
            UITextField *phoneNumber = [weakSelf.tableView viewWithTag:1001];
            
            customerName.enabled = YES;
            phoneNumber.enabled = YES;
            
            [customerName becomeFirstResponder];
            
        }
        else {
            
            DDLogDebug(@"点击删除客户");
            weakSelf.alertVC = [AlertController alertControllerWithTitle:@"确认删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
            weakSelf.alertVC.alertOptionName = @[@"确定",@"取消"];
            [weakSelf presentViewController: weakSelf.alertVC animated: YES completion:^{
                
                
            }];
            
            weakSelf.alertVC.tapExitButtonBlock = ^() {
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            };
            
        }
    };
    
    [self presentViewController: self.alertVC animated: YES completion:^{
        
        
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [self.view addSubview:self.maskView];
    self.maskView.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
    }];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 1000) {
        
    }
    
    else if (textField.tag == 1001) {
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [textField resignFirstResponder];
        
        self.maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.maskView removeFromSuperview];
        
    }];
    
    return YES;
}

@end
