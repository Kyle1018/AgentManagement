//
//  ProductDetailViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "AMProductRelatedInformation.h"

@interface ProductDetailViewController ()

@property(nonatomic,strong)AlertController *alertVC;
@property (weak, nonatomic) IBOutlet UITextField *brandTextFiled;//品牌
@property (weak, nonatomic) IBOutlet UITextField *pmodelTextField;//型号
@property (weak, nonatomic) IBOutlet UILabel *price;//价格
@property (weak, nonatomic) IBOutlet UILabel *drinking;//是否可以直接饮用
@property (weak, nonatomic) IBOutlet UILabel *classification;//分类
@property (weak, nonatomic) IBOutlet UILabel *filter;//过滤介质
@property (weak, nonatomic) IBOutlet UILabel *features;//产品特点
@property (weak, nonatomic) IBOutlet UILabel *putposition;//摆放位置
@property (weak, nonatomic) IBOutlet UILabel *number;//滤芯个数
@property (weak, nonatomic) IBOutlet UILabel *area;//适用地区
@property (weak, nonatomic) IBOutlet UITextField *priceTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *cycle;//换滤芯周期
@property (weak, nonatomic) IBOutlet UITextField *stock_priceTextFiled;//进货价格
@property (weak, nonatomic) IBOutlet UITextField *stock_numberTextFiled;//进货数量
@property(nonatomic,strong)NSMutableDictionary *inputOptionDic;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.productInfo);
    
    
    
    //设置数据
    [self setData];
    
    
    [self signal];
    
}

- (void)setData {
    
    _inputOptionDic = [NSMutableDictionary dictionary];
    
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
    
    [[[self.brandTextFiled rac_textSignal]distinctUntilChanged]subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
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
      
        if (index == 0) {

            //设置单元格accessory
            NSLog(@"%ld",weakSelf.tableView.numberOfSections);
            NSLog(@"%@",weakSelf.tableView.indexPathsForVisibleRows);
            
            for (NSIndexPath *indexPaht in weakSelf.tableView.indexPathsForVisibleRows) {
                
                if (indexPaht.section == 1 && indexPaht.row != 7) {
                    
                    UITableViewCell*cell=[weakSelf.tableView cellForRowAtIndexPath:indexPaht];
                     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                else {
                    
                    UITableViewCell*cell=[weakSelf.tableView cellForRowAtIndexPath:indexPaht];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                    
                }
            }
            
            //设置单元格可以点击
            weakSelf.tableView.allowsSelection = YES;
            //设置可以输入
            weakSelf.brandTextFiled.enabled = YES;
            weakSelf.pmodelTextField.enabled = YES;
            weakSelf.priceTextFiled.enabled = YES;
            weakSelf.stock_priceTextFiled.enabled = YES;
            weakSelf.stock_numberTextFiled.enabled = YES;
            
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
            
            self.alertVC.title = [[self.productRelatedInformationArray firstObject]objectAtIndex:indexPath.row];
            
            self.alertVC.actionButtonArray = [[self.productRelatedInformationArray lastObject]objectAtIndex:indexPath.row];
            
            self.alertVC.alertTag = indexPath.row + 300;
            
            [self presentViewController: self.alertVC animated: YES completion:nil];
        }
        
    }
    
    
}


@end
