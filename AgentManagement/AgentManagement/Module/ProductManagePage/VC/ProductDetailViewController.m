//
//  ProductDetailViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "AlertController.h"
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

@property(nonatomic,strong)NSMutableArray *optionDataArray;
@property(nonatomic,strong)NSMutableArray *optionTitleDataArray;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.productInfo);
    
    //设置数据
    [self setData];
    
}

- (void)setData {
    
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
    
    
    _optionTitleDataArray = [NSMutableArray arrayWithObjects:@"直接饮用",@"分类",@"过滤介质",@"产品特点",@"摆放位置",@"滤芯个数",@"使用地区",@"",@"换芯周期", nil];
    _optionDataArray = [NSMutableArray arrayWithObjects:
                        @[@"可以",@"不可以"],
                        @[@"纯水机",@"家用净水机",@"商用净水器",@"软水机",@"管线机",@"水处理设备",@"龙头净水器",@"净水杯"],
                        @[@"反渗透",@"超滤",@"活性炭",@"PP棉",@"陶瓷纳滤",@"不锈钢滤网",@"微滤",@"其它"],
                        @[@"无废水",@"无桶大通量",@"双出水",@"滤芯寿命提示",@"低废水单出水",@"双模双出水",@"紫外线杀菌",@"TDS显示"],
                        @[@"厨下式",@"龙头式",@"台上式",@"滤芯寿命提示",@"低废水入户过滤",@"壁挂式",@"其它"],
                        @[@"1级",@"2级",@"3级",@"4级",@"5级",@"6级",@"6级以上"],
                        @[@"华北",@"华南",@"华东",@"华中",@"其它"],
                        @[@"cycle"],nil];
    
    for (AMProductRelatedInformation *model in self.productRelatedInformationArray) {
        
        if ([model.key isEqualToString:@"drinking"]) {
            
            [_optionDataArray replaceObjectAtIndex:0 withObject:model.value];
            
        }
        
        else if ([model.key isEqualToString:@"classification"]) {
            
            [_optionDataArray replaceObjectAtIndex:1 withObject:model.value];
        }
        else if ([model.key isEqualToString:@"filter"]) {
            
            [_optionDataArray replaceObjectAtIndex:2 withObject:model.value];
        }
        else if ([model.key isEqualToString:@"features"]) {
            
            [_optionDataArray replaceObjectAtIndex:3 withObject:model.value];
        }
        else if ([model.key isEqualToString:@"putposition"]) {
            
            [_optionDataArray replaceObjectAtIndex:4 withObject:model.value];
        }
        else if ([model.key isEqualToString:@"number"]) {
            
            [_optionDataArray replaceObjectAtIndex:5 withObject:model.value];
        }
        
        else if ([model.key isEqualToString:@"cycle"]) {
            
            [_optionDataArray replaceObjectAtIndex:7 withObject:model.value];
        }
    }
    
    
    
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

            //设置单元格accessory
            for (UITableViewCell*cell in weakSelf.tableView.visibleCells) {
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            //设置单元格可以点击
            weakSelf.tableView.allowsSelection = YES;
            
            
            
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
    
    NSLog(@"点击了单元格");
    
    
}


@end
