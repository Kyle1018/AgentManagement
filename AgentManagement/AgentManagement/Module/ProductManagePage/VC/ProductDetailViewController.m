//
//  ProductDetailViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "AMProductRelatedInformation.h"
#import "ProductManageViewModel.h"
@interface ProductDetailViewController ()

@property(nonatomic,strong)AlertController *alertVC;
@property (weak, nonatomic) IBOutlet UITextField *brandTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *pmodelTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *stock_priceTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *stock_numberTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *drinking;//是否可以直接饮用
@property (weak, nonatomic) IBOutlet UILabel *classification;//分类
@property (weak, nonatomic) IBOutlet UILabel *filter;//过滤介质
@property (weak, nonatomic) IBOutlet UILabel *features;//产品特点
@property (weak, nonatomic) IBOutlet UILabel *putposition;//摆放位置
@property (weak, nonatomic) IBOutlet UILabel *number;//滤芯个数
@property (weak, nonatomic) IBOutlet UILabel *area;//适用地区
@property (weak, nonatomic) IBOutlet UILabel *cycle;//换滤芯周期
@property(nonatomic,strong)NSMutableDictionary *inputOptionDic;
@property(nonatomic,strong)ProductManageViewModel *viewModel;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DDLogDebug(@"%@",self.productInfo);

    //设置数据
    [self setData];
    
    [self signal];
    
}

- (void)setData {
    
    _viewModel = [[ProductManageViewModel alloc]init];
    
    _inputOptionDic = [NSMutableDictionary dictionaryWithDictionary:[self.productInfo toDictionary]];
    
    /**
     *  "add_time" = 1473155835;
     "an_id" = 10;
     area = "\U534e\U4e1c";
     brand = "\U6211\U4eec";
     classification = "\U5546\U7528\U51c0\U6c34\U5668";
     cycle = "2\U4e2a\U6708";
     drinking = "\U53ef\U4ee5";
     features = "\U65e0\U5e9f\U6c34";
     filter = "\U8d85\U6ee4";
     id = 30;
     number = "\U6ee4\U82af\U5bff\U547d\U63d0\U793a";
     pmodel = "";
     price = 100;
     putposition = "4\U7ea7";
     "stock_number" = 100;
     "stock_price" = 100;
     "u_id" = 10;
     */
    
    self.brandTextFiled.text = self.productInfo.brand;
    
    self.pmodelTextField.text = self.productInfo.pmodel;

    self.drinking.text = self.productInfo.drinking;
    
    self.classification.text = self.productInfo.classification;
    
    self.filter.text = self.productInfo.filter;
    
    self.features.text = self.productInfo.features;
    
    self.putposition.text = self.productInfo.putposition;
    
    self.number.text  =self.productInfo.number;
    
    self.area.text = self.productInfo.area;
    
    self.cycle.text = self.productInfo.cycle;
    
    self.priceTextFiled.text = self.productInfo.price;
    
    self.stock_priceTextFiled.text = self.productInfo.stock_price;
    
    self.stock_numberTextFiled.text = self.productInfo.stock_number;
    
    
}

- (void)signal {
    
     __weak typeof(self) weakSelf = self;
    
    [[[self.brandTextFiled rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString* x) {
       
        [weakSelf.inputOptionDic setObject:x forKey:@"brand"];

    }];
    
    [[[self.pmodelTextField rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString* x) {
        
        [weakSelf.inputOptionDic setObject:x forKey:@"pmodel"];
        
    }];
    
    [[[self.priceTextFiled rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString* x) {
        
        [weakSelf.inputOptionDic setObject:x forKey:@"price"];
        
    }];
    
    [[[self.stock_priceTextFiled rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString* x) {
        
        [weakSelf.inputOptionDic setObject:x forKey:@"stock_price"];
        
    }];
    
    [[[self.stock_numberTextFiled rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString* x) {
        
        [weakSelf.inputOptionDic setObject:x forKey:@"stock_number"];
        
    }];

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
      
        //点击了编辑产品选项
        if (index == 0) {
            
            //设置单元格可以点击
            weakSelf.tableView.allowsSelection = YES;
            //设置可以输入
            weakSelf.brandTextFiled.enabled = YES;
            weakSelf.pmodelTextField.enabled = YES;
            weakSelf.priceTextFiled.enabled = YES;
            weakSelf.stock_priceTextFiled.enabled = YES;
            weakSelf.stock_numberTextFiled.enabled = YES;
            [weakSelf.priceTextFiled becomeFirstResponder];

        }
        
        //点击了删除产品选项
        else {

            weakSelf.alertVC = [AlertController alertControllerWithTitle:@"确认删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
            weakSelf.alertVC.alertOptionName = @[@"删除",@"取消"];
            [weakSelf presentViewController: weakSelf.alertVC animated: YES completion:nil];
            
            //点击了删除产品
            weakSelf.alertVC.tapExitButtonBlock = ^() {
             
                //删除请求
                [[weakSelf.viewModel deleteProduct:weakSelf.inputOptionDic]subscribeNext:^(id x) {

                  //  [[NSNotificationCenter defaultCenter]postNotificationName:KDeletaProductInfoNotifi object:nil userInfo:@{@"productInfo":weakSelf.productInfo}];
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                
                }];

            };
            
        }
    };
    
    [self presentViewController: self.alertVC animated: YES completion:^{
        
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    
    if (indexPath.section == 1) {

        self.alertVC = [AlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        // 点击了选项回调
        self.alertVC.tapActionButtonBlock = ^(NSInteger alertTag,NSString* keyName,NSInteger index) {
            
            //根据tag取出对应的label
            UILabel *label = [tableView viewWithTag:alertTag];
            
            //根据点击的下标获取label的内容
            label.text = weakSelf.alertVC.actionButtonArray[index];
            
            //将取出的label内容及key存入字典，用于之后的添加产品请求参数
             [weakSelf.inputOptionDic setObject:label.text forKey:keyName];
            
        };
        
        
        //如果是手动输入零售价格单元格，则不显示alert
        if (indexPath.row == 7) {
            
            [self.alertVC removeFromParentViewController];
            
        }
        else {
            [self.brandTextFiled resignFirstResponder];
            [self.pmodelTextField resignFirstResponder];
            [self.priceTextFiled resignFirstResponder];
            [self.stock_priceTextFiled resignFirstResponder];
            [self.stock_numberTextFiled resignFirstResponder];
        
            self.alertVC.title = [[self.productRelatedInformationArray firstObject]objectAtIndex:indexPath.row];
            
            self.alertVC.actionButtonArray = [[self.productRelatedInformationArray lastObject]objectAtIndex:indexPath.row];
            
            self.alertVC.alertTag = indexPath.row + 300;
            
            [self presentViewController: self.alertVC animated: YES completion:nil];
        }
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)doBack:(id)sender {
    
    DDLogDebug(@"点击了返回");
    __weak typeof(self) weakSelf = self;
    
    self.alertVC = [AlertController alertControllerWithTitle:@"退出此次编辑" message:nil preferredStyle:UIAlertControllerStyleAlert];
    self.alertVC.alertOptionName = @[@"退出",@"取消"];
    [self presentViewController: self.alertVC animated: YES completion:^{
        
        
    }];
    
    self.alertVC.tapExitButtonBlock = ^() {
        
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    };
}

@end
