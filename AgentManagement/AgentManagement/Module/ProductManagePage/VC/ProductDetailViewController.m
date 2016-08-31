//
//  ProductDetailViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "AlertController.h"
@interface ProductDetailViewController ()
@property(nonatomic,strong)AlertController *alertVC;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.view.backgroundColor=[UIColor redColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 10;
    }
    else {
        
        return 20;
    }
}
- (IBAction)editProductAction:(UIButton *)sender {
    
    self.alertVC = [AlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    self.alertVC.actionButtonArray = @[@"编辑产品",@"删除产品"];
    
    __weak typeof(self) weakSelf = self;
    
    self.alertVC.tapActionButtonBlock = ^(OptionName optionName,NSString* keyName,NSInteger index) {
      
        if (index == 0) {
            
            NSLog(@"点击了编辑产品");
        }
        else {
            
            NSLog(@"点击删除产品");
    
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
