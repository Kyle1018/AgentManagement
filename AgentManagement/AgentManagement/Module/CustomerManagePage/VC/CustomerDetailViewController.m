//
//  CustomerDetailViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/18.
//  Copyright © 2016年 KK. All rights reserved.

#import "CustomerDetailViewController.h"
#import "AlertController.h"
#import "CustomerDetailCell.h"
#import "ProductManageViewModel.h"
#import "CustomerManageViewModel.h"
#import "AMAdministrators.h"
@interface CustomerDetailViewController ()

@property(nonatomic,strong)AlertController *alertVC;
@property(nonatomic,assign)BOOL isTapEditing;
@property(nonatomic,strong)CustomerManageViewModel *viewModel;
@property(nonatomic,strong)NSMutableDictionary *customerDic;
@property(nonatomic,strong)ProductManageViewModel *productManageViewModel;
@property(nonatomic,strong)NSMutableArray *pickerDataArray;
@property(nonatomic,strong)NSMutableArray *brandAndModelArray;
@property(nonatomic,strong)PickerView *pickerView;
@property(nonatomic,strong)PickerViewProtocol *protocol;
@property(nonatomic,strong)PickerDataView *datePicker;
@property(nonatomic,copy)NSString *dateStr;
@property(nonatomic,strong)NSMutableArray *administratorIdArray;
@property(nonatomic,strong)NSMutableArray *optionArray;
@property(nonatomic,assign)NSInteger lRow;
@property(nonatomic,strong)NSMutableArray *productInfoArray;
@property(nonatomic,assign)NSInteger textTag;
@end

@implementation CustomerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _customerDic = [NSMutableDictionary dictionaryWithDictionary:[self.customerModel toDictionary]];
    
    NSArray *orderArray = _customerDic[@"orderArray"];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (AMOrder *order in orderArray) {
        
        NSDictionary *dic = [order toDictionary];
        
        [array addObject:dic];
    }
    [_customerDic removeObjectForKey:@"orderArray"];
    [_customerDic safeSetObject:array forKey:@"order"];

    _protocol = [[PickerViewProtocol alloc]init];
    
    [self requestData];

}

- (void)requestData {
    
    self.viewModel = [[CustomerManageViewModel alloc]init];
    
     self.productManageViewModel = [[ProductManageViewModel alloc]init];
    
    self.administratorIdArray = [NSMutableArray array];
    
    self.productInfoArray = [NSMutableArray arrayWithObjects:@"购买机型",@"购买时间",@"安装时间",@"换芯周期", nil];
    
    //请求产品品牌和型号:使用请求产品品牌和型号时的viewmodel——ProductManageViewModel
    [[self.productManageViewModel requestProductBrandAndPmodelData]subscribeNext:^(id x) {
        
        if ([x isKindOfClass:[NSMutableArray class]]) {
            
            self.brandAndModelArray = x;
            
            [self.brandAndModelArray removeObjectAtIndex:1];
            
            NSMutableArray *array = [NSMutableArray arrayWithObjects:x[0], [x[1]objectAtIndex:0],nil];
            
            [self.productInfoArray replaceObjectAtIndex:0 withObject:array];
        }
    }];
    
    //请求换芯周期：使用请求产品相关信息时的viewmodel——ProductManageViewModel
    [[self.productManageViewModel requstProductInformationData]subscribeNext:^(id x) {
        
        if ([x isKindOfClass:[NSMutableArray class]]) {
            
            NSMutableArray *cycleArray = [NSMutableArray arrayWithArray:[[x lastObject]lastObject]];
            
            NSMutableArray *array = [NSMutableArray arrayWithObject:cycleArray];
            
            [self.productInfoArray replaceObjectAtIndex:3 withObject:array];
        }
        
        
    }];
    
    //请求管理员数据
    [[self.viewModel requestAdministratorList]subscribeNext:^(NSMutableArray*x) {
        
        NSMutableArray *administratorArray = [NSMutableArray array];
        
        for ( AMAdministrators *administrators in x) {
            
            [administratorArray addObject:[NSString stringWithFormat:@"%@          %@",administrators.nickname,administrators.username]];
            
            [self.administratorIdArray addObject:@(administrators.a_id)];
        }
        NSMutableArray *array = [NSMutableArray arrayWithObject:administratorArray];
        
        self.optionArray = [NSMutableArray arrayWithObject:array];
    }];
}

#pragma mark -UITabelViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        
        return 80;
    }
    else {
        
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return  3+self.customerModel.orderArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 3+self.customerModel.orderArray.count-1) {
        
        return 2;
    }
    else {
        
        return 4;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cutomerDetialCellID";
    
    CustomerDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        cell= [[CustomerDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }

    //赋值
    [cell setDataWithTitle:@[@[@"客户姓名:",@"手机号:",@"客户地址:",@"详细地址:"],
                             @[@"TDS值",@"PH值",@"硬度",@"余氯值"],
                             @[@"购买品牌:",@"购买时间:",@"安装时间:",@"换芯周期:"],
                             @[@"管理员:",@"管理员手机号:"]]
                  customer:self.customerModel
                 indexPaht:indexPath];
  

    
    if (indexPath.section == 0 &&indexPath.row==3) {
        
        cell.textView.tag = 999;
        cell.textField.tag=0;
        
    }
    else {
        NSString *textFieldTag = [NSString stringWithFormat:@"10%ld%ld",indexPath.section,indexPath.row];
        
        cell.textField.tag = [textFieldTag integerValue];
        cell.textView.tag =0;
    }
    
    //根据是否是编辑状态决定单元格是否可以编辑
    cell.textView.editable = cell.textField.enabled = self.tableView.allowsSelection = self.isTapEditing==YES?YES:NO;
    
    
    @weakify(self);
    //textfield输入
    [[[cell.textField rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString * x) {
   
        @strongify(self);
        if (indexPath.section == 0) {
            
            switch (indexPath.row) {
                case 0:
                    [self.customerDic safeSetObject:x forKey:@"name"];
                    break;
                case 1:
                    [self.customerDic safeSetObject:x forKey:@"phone"];
                    break;
                    
                default:
                    break;
            }
        }
        
        else if (indexPath.section == 1) {
            
            switch (indexPath.row) {
                case 0:
                    [self.customerDic safeSetObject:@([x integerValue]) forKey:@"tds"];
                    break;
                case 1:
                     [self.customerDic safeSetObject:@([x integerValue]) forKey:@"ph"];
                    break;
                case 2:
                     [self.customerDic safeSetObject:@([x integerValue]) forKey:@"hardness"];
                    break;
                case 3:
                     [self.customerDic safeSetObject:@([x integerValue]) forKey:@"chlorine"];
                    break;
                default:
                    break;
            }
        }

        DDLogDebug(@"_________________%@",x);
    }];
    

    //textview输入
    [[[cell.textView rac_textSignal]distinctUntilChanged]subscribeNext:^(id x) {
        @strongify(self);
        if (indexPath.section == 0 && indexPath.row == 3) {
            
            [self.customerDic safeSetObject:x forKey:@"address"];
        }
    }];
    
    return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    UITextView*textView = [self.view viewWithTag:999];
     
    [textView.delegate textView:textView shouldChangeTextInRange:NSMakeRange(textView.text.length, 0) replacementText:@"\n"];
        
    UITextField *textField = [self.view viewWithTag:_textTag];
    [textField resignFirstResponder];


    self.pickerView = [PickerView showAddTo:kAppWindow];
    self.pickerView.picker.delegate = self.protocol;
    self.pickerView.picker.dataSource = self.protocol;

    CustomerDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //地址picker
    if (indexPath.section == 0) {
        
        if (indexPath.row == 2) {
            
            [[self.viewModel requestAreaListData:0 lIndex:0]subscribeNext:^(NSMutableArray* x) {
                
                self.protocol.pickerDataArray = x;
                
                self.protocol.pickerDataArrayB = x[1];
                
                self.protocol.pickerDataArrayC =  x[2];
                
                [self.pickerView.picker reloadAllComponents];
                
            }];
            
            @weakify(self);
            self.protocol.didSelectRow = ^(NSInteger row,NSInteger component){
                
                @strongify(self);
                
                if (component == 0 || component == 1) {
                    
                    if (component == 0) {
                        
                        _lRow = row;
                        
                    }
                    
                    [self.protocol.pickerDataArray removeAllObjects];
                    [self.protocol.pickerDataArrayB removeAllObjects];
                    [self.protocol.pickerDataArrayC removeAllObjects];
                    
                    [[self.viewModel requestAreaListData:component==0?row:self.lRow lIndex:component==0?0:row]subscribeNext:^(NSMutableArray* x) {
                        
                        self.protocol.pickerDataArray = x;
                        
                        self.protocol.pickerDataArrayB = x[1];
                        
                        self.protocol.pickerDataArrayC = x[2];
                        
                        [self.pickerView.picker selectedRowInComponent:1];
                        
                        [self.pickerView.picker selectedRowInComponent:2];
                        
                        [self.pickerView.picker reloadAllComponents];
                        
                    }];
                }
                
            };
            
            self.pickerView.tapConfirmBlock = ^() {
                
                @strongify(self);
    
                NSString*province = [self.protocol.pickerDataArray[0]objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
                
                NSString*city = [ self.protocol.pickerDataArray[1]objectAtIndex:[self.pickerView.picker selectedRowInComponent:1]];
                
                NSString*town= [ self.protocol.pickerDataArray[2]objectAtIndex:[self.pickerView.picker selectedRowInComponent:2]];
                
                NSString *address = [NSString stringWithFormat:@"%@市",province];
                
                NSString *str = @"";
                
                if ([address isEqualToString:city]) {
                    
                    str = [NSString stringWithFormat:@"%@%@",city,town];
                    
                }
                else {
                    
                    str = [NSString stringWithFormat:@"%@%@%@",province,city,town];
                    
                }
           
                cell.labelA.text = str;
  
                [self.customerDic safeSetObject:province forKey:@"province"];
                [self.customerDic safeSetObject:city forKey:@"city"];
                [self.customerDic safeSetObject:town forKey:@"county"];
                
            };

        }
        else {
            
            [self.pickerView removeFromSuperview];
        }
        
    }
    
    else if (indexPath.section == 1) {
        
        [self.pickerView removeFromSuperview];
        
    }
    
    //管理员姓名；管理员手机号
    else if (indexPath.section == 3+self.customerModel.orderArray.count-1) {
        
        //管理员姓名及电话
        self.protocol.pickerDataArray = self.optionArray[0];
        [self.pickerView.picker reloadAllComponents];
        
        self.protocol.didSelectRow = nil;
        
        @weakify(self);
        _pickerView.tapConfirmBlock = ^() {
            
            @strongify(self);
 
            NSString *str = [[[self.optionArray firstObject]objectAtIndex:0]objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
            
            NSArray *list = [str componentsSeparatedByString:@" "];
    
            
            if (indexPath.row == 0) {
                
                cell.labelA.text = [list firstObject];
                NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:indexPath.section];
                CustomerDetailCell *cellB = [tableView cellForRowAtIndexPath:path];
                cellB.labelA.text = [list lastObject];

            }
            else {
                NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
                CustomerDetailCell *cellA = [tableView cellForRowAtIndexPath:path];
                cellA.labelA.text = [list firstObject];
                cell.labelA.text = [list lastObject];
    
            }
            
            [self.customerDic safeSetObject:[self.administratorIdArray objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]] forKey:@"a_id"];
        };
    }
    
    //订单信息
    else {
        //产品信息
        NSMutableArray *orderArray=self.customerDic[@"order"];
        
       NSMutableDictionary *dic= [NSMutableDictionary dictionaryWithDictionary:orderArray[indexPath.section-2]];

        if (indexPath.row == 0 || indexPath.row == 3) {
 
            self.protocol.pickerDataArray = self.productInfoArray[indexPath.row];
            
            [self.protocol.pickerDataArrayB removeAllObjects];
            
            if ([self.productInfoArray[indexPath.row] count]>1) {
                
                self.protocol.pickerDataArrayB = self.brandAndModelArray[1];
            }
            [self.pickerView.picker reloadAllComponents];
            
            @weakify(self);
            
            self.protocol.didSelectRow = nil;
            
            _pickerView.tapConfirmBlock = ^() {
    
                @strongify(self)
                
                if (indexPath.row == 0) {
     
                    NSString *brand = [self.brandAndModelArray[0]objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
                    
                    NSArray *pmodelArray = [self.brandAndModelArray[1] objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
                    
                    NSString *pmodel = [pmodelArray objectAtIndex:[self.pickerView.picker selectedRowInComponent:1]];
                    
                    NSString *str = [NSString stringWithFormat:@"%@     %@",brand,pmodel];
                    
                    cell.labelA.text = str;
                    
                    [dic safeSetObject:brand forKey:@"brand"];
                    
                    [dic safeSetObject:pmodel forKey:@"pmodel"];
                    
                     [orderArray replaceObjectAtIndex:indexPath.section-2 withObject:dic];
                }
                else {
                    
                    NSString *str =  [[self.productInfoArray[indexPath.row]objectAtIndex:0]objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
                    cell.labelA.text = str;
                    
                    [dic safeSetObject:str forKey:@"cycle"];
                    
                    [orderArray replaceObjectAtIndex:indexPath.section-2 withObject:dic];
                }
                
                [self.customerDic safeSetObject:orderArray forKey:@"order"];
         
 
            };
        }
        
        else {
            
            [self.pickerView removeFromSuperview];
            
            _datePicker = [PickerDataView showDateAddTo:[UIApplication sharedApplication].keyWindow];
            
            _dateStr = [NSString getDateStr:_datePicker.datePicker.date];
            
            [[_datePicker.datePicker rac_signalForControlEvents:UIControlEventValueChanged]subscribeNext:^(UIDatePicker* x) {
                
                self.dateStr=[NSString getDateStr:x.date];
                
            }];
            
            @weakify(self);
            _datePicker.tapConfirmBlock = ^() {
                
                @strongify(self);
                
                cell.labelA.text = self.dateStr;
                
                if (indexPath.row == 1) {
                    
                    NSString *date = [NSString stringWithFormat:@"%@",self.datePicker.datePicker.date];
                    [dic safeSetObject:date forKey:@"buy_time"];
                    
                    [orderArray replaceObjectAtIndex:indexPath.section-2 withObject:dic];
                    
                   // [self.orderDic safeSetObject:date forKey:@"buy_time"];
                }
                else if(indexPath.row == 2) {
                    
                    
                    NSString *date = [NSString stringWithFormat:@"%@",self.datePicker.datePicker.date];
                    [dic safeSetObject:date forKey:@"install_time"];
                    
                    [orderArray replaceObjectAtIndex:indexPath.section-2 withObject:dic];
                   // [self.orderDic safeSetObject:date forKey:@"install_time"];
                }
                
                 [self.customerDic safeSetObject:orderArray forKey:@"order"];
            

            };
        }
    }

}

#pragma mark - Action
//编辑菜单
- (IBAction)editCutomerAction:(UIButton *)sender {
    
    
    self.alertVC = [AlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    self.alertVC.actionButtonArray = @[@"编辑客户",@"删除客户"];
  
    @weakify(self);
    self.alertVC.tapActionButtonBlock = ^(NSInteger alertTag,NSString* keyName,NSInteger index) {
        
        @strongify(self);
        if (index == 0) {
            
            DDLogDebug(@"点击了编辑客户");

            self.isTapEditing = YES;
            [self.tableView reloadData];

            self.title = @"编辑客户信息";
            self.navigationItem.rightBarButtonItems = nil;
            UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            saveBtn.frame = CGRectMake(0, 0, 44, 44);
            [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
            [saveBtn setTitleColor:[UIColor colorWithHex:@"007AFF"] forState:UIControlStateNormal];
            saveBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
            
            //保存编辑信息事件
            [[saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                
                
                
                [[self.viewModel requestEditingCustomer:self.customerDic]subscribeNext:^(id x) {
                    
                }];
                //编辑保存请求
     
                
            }];
            
        }
        else {
            
            DDLogDebug(@"点击删除客户");
            self.alertVC = [AlertController alertControllerWithTitle:@"确认删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
            self.alertVC.alertOptionName = @[@"确定",@"取消"];
            [self presentViewController: self.alertVC animated: YES completion:nil];
            
            @weakify(self);
            //点击了确定删除
            self.alertVC.tapExitButtonBlock = ^() {
                @strongify(self);
                
                //删除请求
                
                NSInteger customer_id = self.customerModel.cutomer_id;
                
               [[self.viewModel requestDeleteCustomer:customer_id]subscribeNext:^(id x) {
                   
                  [self.navigationController popViewControllerAnimated:YES];
                   
               }];
                
                
               
            };
            
        }
    };
    
    [self presentViewController: self.alertVC animated: YES completion:^{
        
        
    }];
}

#pragma mark -UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    _textTag = textField.tag;
    
    return YES;
}

//进入添加产品页面
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier compare:@"AddCustomerBSegue"]==NO) {
        
        id page2=segue.destinationViewController;
        

        NSMutableArray *orderArray = [NSMutableArray array];
        
        for (AMOrder *order in self.customerModel.orderArray) {
            
            NSDictionary *dic = [order toDictionary];
            
            [orderArray addObject:dic];
        }
        
        NSMutableDictionary *customerDic = [NSMutableDictionary dictionaryWithDictionary:[self.customerModel toDictionary]];
        
        [customerDic removeObjectForKey:@"orderArray"];
        
        [customerDic safeSetObject:orderArray forKey:@"order"];

        [page2 setValue:customerDic forKey:@"addCutomerInfoDic"];
    }
    
}

#pragma mark - SuperMethod
-(void)doBack:(id)sender
{
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
