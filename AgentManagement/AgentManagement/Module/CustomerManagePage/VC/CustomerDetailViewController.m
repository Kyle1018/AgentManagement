//
//  CustomerDetailViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/18.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CustomerDetailViewController.h"
#import "AlertController.h"
@interface CustomerDetailViewController ()

@property(nonatomic,strong)AlertController *alertVC;

@end

@implementation CustomerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

//编辑菜单
- (IBAction)editCutomerAction:(UIButton *)sender {
    
    
    self.alertVC = [AlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    self.alertVC.actionButtonArray = @[@"编辑客户",@"删除客户"];
    
    __weak typeof(self) weakSelf = self;
    
    self.alertVC.tapActionButtonBlock = ^(OptionName optionName,NSString* keyName,NSInteger index) {
        
        if (index == 0) {
            
            NSLog(@"点击了编辑客户");
        }
        else {
            
            NSLog(@"点击删除客户");
            
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

@end
