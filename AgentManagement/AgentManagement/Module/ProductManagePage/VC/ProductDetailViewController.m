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
@property(nonatomic,strong)NSMutableDictionary *inputOptionDic;
@property(nonatomic,strong)ProductManageViewModel *viewModel;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger textFieldTag;
@property(nonatomic,strong)NSArray *keyNameArray;
@property(nonatomic,assign)BOOL isTapEditing;
@property (weak, nonatomic) IBOutlet UITextField *stock_numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *stock_priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *brandTextField;
@property (weak, nonatomic) IBOutlet UITextField *pmodelTextField;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DDLogDebug(@"%@",self.productInfo);
    
    //设置数据
    [self setData];
}

- (void)setData {
    
    _viewModel = [[ProductManageViewModel alloc]init];

    _dataArray = [NSMutableArray arrayWithObjects:@[self.productInfo.brand==nil?@"":self.productInfo.brand,self.productInfo.pmodel==nil?@"":self.productInfo.pmodel],@[self.productInfo.drinking==nil?@"":self.productInfo.drinking,self.productInfo.classification==nil?@"":self.productInfo.classification,self.productInfo.filter==nil?@"":self.productInfo.filter,self.productInfo.features==nil?@"":self.productInfo.features,self.productInfo.putposition==nil?@"":self.productInfo.putposition, self.productInfo.number==nil?@"":self.productInfo.number,self.productInfo.area==nil?@"":self.productInfo.area,self.productInfo.price==nil?@"":self.productInfo.price,self.productInfo.cycle==nil?@"":self.productInfo.cycle],@[self.productInfo.stock_price==nil?@"":self.productInfo.stock_price,self.productInfo.stock_number==nil?@"":self.productInfo.stock_number],nil];
    
    _keyNameArray = @[@[@"brand",@"pmodel"],@[@"drinking",@"classification",@"filter",@"features",@"putposition",@"number",@"area",@"price",@"cycle"],@[@"stock_price",@"stock_number"]];
    
    _inputOptionDic = [NSMutableDictionary dictionaryWithDictionary:[self.productInfo toDictionary]];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *tagStr = [NSString stringWithFormat:@"%ld10%ld",(long)indexPath.section,(long)indexPath.row];
    
    UIView *view = [tableView viewWithTag:[tagStr integerValue]];
    
    if ([view isKindOfClass:[UITextField class]]) {
        
        UITextField *textField = (UITextField*)view;
    
        textField.text = [_dataArray[indexPath.section]objectAtIndex:indexPath.row];
        
    }
    else if ([view isKindOfClass:[UILabel class]]) {
        
        UILabel *label = (UILabel*)view;
        
        label.text = [_dataArray[indexPath.section]objectAtIndex:indexPath.row];
    }
    
    return 44;
}

#pragma mark - Action
- (IBAction)editProductAction:(UIButton *)sender {
    
    self.alertVC = [AlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    self.alertVC.actionButtonArray = @[@"编辑产品",@"删除产品"];
    
    @weakify(self);
    self.alertVC.tapActionButtonBlock = ^(NSInteger alertTag,NSString* keyName,NSInteger index) {
      
        @strongify(self);
        //点击了编辑产品选项
        if (index == 0) {
            
            //设置单元格可以点击
            self.tableView.allowsSelection = YES;
            self.isTapEditing = YES;
            self.title = @"编辑产品信息";
            self.navigationItem.rightBarButtonItems = nil;
            UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            saveBtn.frame = CGRectMake(0, 0, 44, 44);
            [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
            [saveBtn setTitleColor:[UIColor colorWithHex:@"007AFF"] forState:UIControlStateNormal];
            saveBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
            
            
            RACSignal*a=[self.brandTextField.rac_textSignal map:^id(NSString* value) {
                
                return @(value.length>0);
            }];
            
            RACSignal*b=[self.pmodelTextField.rac_textSignal map:^id(NSString* value) {
                
                return @(value.length>0);
            }];
            
            RACSignal*c=[self.stock_numberTextField.rac_textSignal map:^id(NSString* value) {
                
                return @(value.length>0);
            }];
            
            RACSignal*d=[self.stock_priceTextField.rac_textSignal map:^id(NSString* value) {
                
                return @(value.length>0);
            }];
            
            RACSignal *signUpActiveSignal =
            [RACSignal combineLatest:@[a, b,c,d]
                              reduce:^id(NSNumber*a, NSNumber *b,NSNumber*c,NSNumber*d){
                                  
                                  return @([a boolValue]&&[b boolValue]&&[c boolValue]&&[d boolValue]);
                              }];
            
            RAC(saveBtn,enabled) = [signUpActiveSignal map:^id(id value) {
                
                if ([value boolValue]) {
                    
                    [saveBtn setTitleColor:[UIColor colorWithHex:@"007AFF"] forState:UIControlStateNormal];
                    
                }
                else {
                    
                    [saveBtn setTitleColor:[UIColor colorWithHex:@"9b9b9b"] forState:UIControlStateNormal];
                    
                }
                
                return value;
            }];
            
            //保存编辑信息事件
            [[saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {

                [[[[self.viewModel editProduct:self.inputOptionDic]filter:^BOOL(id value) {
                    
                    if ([x isKindOfClass:[AMProductInfo class]]) {
                        
                        AMProductInfo *productInfo = (AMProductInfo*)x;
                        
                        [self.dataArray removeAllObjects];
                        
                        NSArray *array = @[@[productInfo.brand,productInfo.pmodel],
                                           @[productInfo.drinking,productInfo.classification,productInfo.filter,productInfo.features,productInfo.putposition,productInfo.number,productInfo.area,productInfo.price,productInfo.cycle],
                                           @[productInfo.stock_price,productInfo.stock_number]];
                        [self.dataArray addObjectsFromArray:array];
                        
                        [self.tableView reloadData];
                        
                        [MBProgressHUD showText:@"编辑产品保存成功"];
                        
                        return YES;
                    }
                    
                    else {
                        
                        [MBProgressHUD showText:@"编辑产品保存失败"];
                        
                        return NO;
                    }
                    
                    
                }]delay:3]subscribeNext:^(id x) {
                   
                     [self.navigationController popViewControllerAnimated:YES];
                    
                }];
  
            }];
        }
        
        //点击了删除产品选项
        else {

            self.alertVC = [AlertController alertControllerWithTitle:@"确认删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
            self.alertVC.alertOptionName = @[@"删除",@"取消"];
            [self presentViewController: self.alertVC animated: YES completion:nil];
            
            //点击了删除产品
            self.alertVC.tapExitButtonBlock = ^() {
            
                @strongify(self);
                
                //删除请求
                [[self.viewModel deleteProduct:self.inputOptionDic]subscribeNext:^(id x) {

                    [self.navigationController popViewControllerAnimated:YES];
                
                }];

            };
            
        }
    };
    
    [self presentViewController: self.alertVC animated: YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section==0 || indexPath.row == 7 || indexPath.section==2) {
        
        [self.alertVC removeFromParentViewController];
        self.alertVC.tapActionButtonBlock = nil;
        
        NSInteger tag = [[NSString stringWithFormat:@"%ld10%ld",(long)indexPath.section,(long)indexPath.row]integerValue];
        UITextField *textFiled = [tableView viewWithTag:tag];
        textFiled.enabled = YES;
        [textFiled becomeFirstResponder];
        
        [[[textFiled rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString* x) {
            
            [self.inputOptionDic setObject:x forKey:[self.keyNameArray[indexPath.section]objectAtIndex:indexPath.row]];
        }];
        
        _textFieldTag = textFiled.tag;
    }
    else {
        
        UITextField *textField = [tableView viewWithTag:_textFieldTag];
        
        [textField resignFirstResponder];
        
        self.alertVC = [AlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        @weakify(self);
        // 点击了选项回调
        self.alertVC.tapActionButtonBlock = ^(NSInteger alertTag,NSString* keyName,NSInteger index) {
            
            @strongify(self);
            //根据tag取出对应的label
            NSInteger tag = [[NSString stringWithFormat:@"%ld10%ld",(long)indexPath.section,(long)indexPath.row]integerValue];
            
            UILabel *label = [tableView viewWithTag:tag];
            
            //根据点击的下标获取label的内容
            label.text = self.alertVC.actionButtonArray[index];
            
            //将取出的label内容及key存入字典，用于之后的添加产品请求参数
            [self.inputOptionDic setObject:label.text forKey:[self.keyNameArray[indexPath.section]objectAtIndex:indexPath.row]];
            
        };
        
        self.alertVC.title = [[self.productRelatedInformationArray firstObject]objectAtIndex:indexPath.row+2];
        
        self.alertVC.actionButtonArray = [[self.productRelatedInformationArray lastObject]objectAtIndex:indexPath.row+2];
        
        [self presentViewController: self.alertVC animated: YES completion:nil];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)doBack:(id)sender {
    
    if (self.isTapEditing == YES) {
        
        self.alertVC = [AlertController alertControllerWithTitle:@"退出此次编辑" message:nil preferredStyle:UIAlertControllerStyleAlert];
        self.alertVC.alertOptionName = @[@"退出",@"取消"];
        [self presentViewController: self.alertVC animated: YES completion:^{
            
            
        }];
        
        @weakify(self);
        self.alertVC.tapExitButtonBlock = ^() {
            
            @strongify(self);
            [self.navigationController popToRootViewControllerAnimated:YES];
        };
        
    }
    else {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
