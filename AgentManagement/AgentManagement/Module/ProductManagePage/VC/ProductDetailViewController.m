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

@property (strong, nonatomic) IBOutlet UILabel *brand;//品牌

@property (strong, nonatomic) IBOutlet UILabel *pmodel;//型号



@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.productInfo);
    
//    self.label.text = @"hehe";
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITabelViewDelegate;UITabelViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 10;
    }
    else {
        
        return 20;
    }
}

#pragma mark - Action
- (IBAction)editProductAction:(UIButton *)sender {
    
    self.alertVC = [AlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    self.alertVC.actionButtonArray = @[@"编辑产品",@"删除产品"];
    
    __weak typeof(self) weakSelf = self;
    
    self.alertVC.tapActionButtonBlock = ^(NSInteger alertTag,NSString* keyName,NSInteger index) {
      
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
