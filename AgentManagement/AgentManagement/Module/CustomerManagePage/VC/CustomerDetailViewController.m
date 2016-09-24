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
#import "AMSales.h"
#import "AMAdministrators.h"
@interface CustomerDetailViewController ()

@property(nonatomic,strong)AlertController *alertVC;

@property(nonatomic,strong)UIView *maskView;

@property(nonatomic,strong)NSArray *titleArray;

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
@property(nonatomic,strong)NSMutableArray *salersIdArray;
@property(nonatomic,strong)NSMutableArray *administratorIdArray;
@property(nonatomic,strong)NSMutableArray *optionArray;
@property(nonatomic,assign)NSInteger lRow;
@property(nonatomic,strong)NSMutableArray *productInfoArray;
@end

@implementation CustomerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _titleArray = @[@[@"客户姓名:",@"手机号:",@"客户地址:",@"详细地址:"],@[@"TDS值",@"PH值",@"硬度",@"余氯值"],@[@"购买品牌:",@"购买时间:",@"安装时间:",@"换芯周期:"],@[@"管理员:",@"管理员手机号:"]];
    
    _customerDic = [NSMutableDictionary dictionaryWithDictionary:[self.customerModel toDictionary]];
    
    _viewModel = [[CustomerManageViewModel alloc]init];
    
    _protocol = [[PickerViewProtocol alloc]init];
    
    _salersIdArray = [NSMutableArray array];
    
    _administratorIdArray = [NSMutableArray array];
    
    _productInfoArray = [NSMutableArray arrayWithObjects:@"购买机型",@"购买时间",@"安装时间",@"换芯周期", nil];
    
   // _optionArray = [NSMutableArray arrayWithObjects:@"管理员姓名",@"管理员手机号", nil];
    
    self.productManageViewModel = [[ProductManageViewModel alloc]init];
    
    [self observeData];
    

 
}


- (void)observeData {
    
    [RACObserve(self.productManageViewModel, productAndModelArray)subscribeNext:^(NSMutableArray* x) {
        
        [x removeObjectAtIndex:1];
        
        self.brandAndModelArray = x;
        
        NSMutableArray *array = [NSMutableArray arrayWithObjects:x[0], [x[1]objectAtIndex:0],nil];
        
        [self.productInfoArray replaceObjectAtIndex:0 withObject:array];
    }];
    
    [RACObserve(self.productManageViewModel, productRelatedInformationArray)subscribeNext:^(id x) {
        
        NSMutableArray *cycleArray = [NSMutableArray arrayWithArray:[[x lastObject]lastObject]];
        
        NSMutableArray *array = [NSMutableArray arrayWithObject:cycleArray];
        
        [self.productInfoArray replaceObjectAtIndex:3 withObject:array];
    }];
}

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
    
    if (section == 0) {//第一组
        
        return 4;
    }
    
    else if (section == 1) {//第二组
        
        return 4;
    }
    
    else if (section == 3+self.customerModel.orderArray.count-1) {
        
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

    [cell setDataWithTitle:_titleArray customer:self.customerModel indexPaht:indexPath];
  
    cell.textView.editable = cell.textField.enabled = self.tableView.allowsSelection = self.isTapEditing==YES?YES:NO;
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        
        if (indexPath.section == 0 && indexPath.row==3) {
            
            cell.textView.tag = 999;
        }
        else if (indexPath.section==0 && indexPath.row ==2){
            
            cell.labelA.tag = 9999;
        }
        else {
            
            NSString *s = [NSString stringWithFormat:@"%ld500%ld",(long)indexPath.section,(long)indexPath.row];
            
            cell.textField.tag = [s integerValue];
        }
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    else {
        
        cell.textView.tag = cell.textField.tag = 0;
        
        cell.accessoryType = self.isTapEditing==YES?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    }
    
    return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //地址picker
    if (indexPath.section == 0) {
        
        if (indexPath.row == 2) {
            
         //   [ [self.view viewWithTag:_textTag] resignFirstResponder];
            
            self.pickerView = [PickerView showAddTo:[UIApplication sharedApplication].keyWindow];
            self.pickerView.picker.delegate = self.protocol;
            self.pickerView.picker.dataSource = self.protocol;
            
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
                
                UILabel *adressLabel = [self.view viewWithTag:9999];
            
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
                
                
                adressLabel.text = str;
                
              //  [self.addCutomerInfoDic safeSetObject:provinceLabel.text forKey:@"province"];
              //  [self.addCutomerInfoDic safeSetObject:cityLabel.text forKey:@"city"];
              //  [self.addCutomerInfoDic safeSetObject:townLabel.text forKey:@"county"];
                
            };

        }
        
    }
    else if (indexPath.section == 1) {
        
        
    }
    else if (indexPath.section == 3+self.customerModel.orderArray.count-1) {
        
        //管理员姓名及电话
        
        self.pickerView = [PickerView showAddTo:[UIApplication sharedApplication].keyWindow];
        self.pickerView.picker.delegate = self.protocol;
        self.pickerView.picker.dataSource = self.protocol;
        
        self.protocol.pickerDataArray = self.optionArray[0];
        [self.pickerView.picker reloadAllComponents];
        
        self.protocol.didSelectRow = nil;
        
        @weakify(self);
        _pickerView.tapConfirmBlock = ^() {
            
            @strongify(self);
            
            UILabel *label = [tableView viewWithTag:1000+indexPath.row];
            
            label.text=[[self.optionArray[indexPath.row]objectAtIndex:0]objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
            
            if (indexPath.row == 0) {
                
              //  NSNumber* salersId = [self.salersIdArray objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
                
               // [self.addCutomerInfoDic safeSetObject:salersId forKey:@"s_id"];
            }
            else {
               
              //  NSNumber* administratorsId = [self.administratorIdArray objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
                
               // [self.addCutomerInfoDic safeSetObject:administratorsId forKey:@"a_id"];
            }
        };
    }
    
    else {
        //产品信息
        if (indexPath.row == 0 || indexPath.row == 3) {
            
            self.pickerView = [PickerView showAddTo:[UIApplication sharedApplication].keyWindow];
            self.pickerView.picker.delegate = self.protocol;
            self.pickerView.picker.dataSource = self.protocol;
            
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
                
                for (int i =0; i<[self.pickerView.picker numberOfComponents]; i++) {
                    
                    UILabel *label = [self.view viewWithTag:9999];
                    
                    NSString *str = [[self.productInfoArray[indexPath.row]objectAtIndex:i]objectAtIndex:[self.pickerView.picker selectedRowInComponent:i]];
                    label.text = str;
                    
                    /*
                    if (label.tag == 1000) {
                        
                        [self.orderDic safeSetObject:str forKey:@"brand"];
                        
                    }
                    else if (label.tag == 1001) {
                        
                        [self.orderDic safeSetObject:str forKey:@"pmodel"];
                    }
                    else if (label.tag == 1003) {
                        
                        [self.orderDic safeSetObject:str forKey:@"cycle"];
                        
                    }
                     */
                }
                
            };
        }
        
        else {
            
            _datePicker = [PickerDataView showDateAddTo:[UIApplication sharedApplication].keyWindow];
            
            _dateStr = [NSString getDateStr:_datePicker.datePicker.date];
            
            [[_datePicker.datePicker rac_signalForControlEvents:UIControlEventValueChanged]subscribeNext:^(UIDatePicker* x) {
                
                self.dateStr=[NSString getDateStr:x.date];
                
            }];
            
            @weakify(self);
            _datePicker.tapConfirmBlock = ^() {
                
                @strongify(self);
                
                UILabel *label = [self.view viewWithTag:9999];
                
                label.text =  self.dateStr;
                
                
                /*
                if (label.tag == 2001) {
                    
                    NSString *date = [NSString stringWithFormat:@"%@",self.datePicker.datePicker.date];
                    
                    [self.orderDic safeSetObject:date forKey:@"buy_time"];
                    
                }
                else if (label.tag == 2002) {
                    
                    NSString *date = [NSString stringWithFormat:@"%@",self.datePicker.datePicker.date];
                    
                    [self.orderDic safeSetObject:date forKey:@"install_time"];
                }
                 */
                
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

            self.navigationItem.rightBarButtonItems = nil;
            UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            saveBtn.frame = CGRectMake(0, 0, 44, 44);
            [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
            [saveBtn setTitleColor:[UIColor colorWithHex:@"007AFF"] forState:UIControlStateNormal];
            saveBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
            
            [self requestEditingData];
        
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    UITextField *input = [self.view viewWithTag:textField.tag];
    
    [[[input rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString * x) {
        
        if (textField.tag == 5000) {//客户姓名
    
            [self.customerDic safeSetObject:x forKey:@"name"];

        }
        else if (textField.tag == 5001) {
         
            [self.customerDic safeSetObject:x forKey:@"phone"];
        }
        else if (textField.tag == 15000) {
     
            [self.customerDic safeSetObject:x forKey:@"tds"];
        }
        else if (textField.tag == 15001) {
    
            [self.customerDic safeSetObject:x forKey:@"ph"];
        }
        else if (textField.tag == 15002) {
     
            [self.customerDic safeSetObject:x forKey:@"hardness"];
        }
        else if (textField.tag == 15003) {
            
            [self.customerDic safeSetObject:x forKey:@"chlorine"];
        }

        DDLogDebug(@"_________________%@",x);
    }];
    
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    

    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark -UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    UITextView *input = [self.view viewWithTag:textView.tag];
 
    [[[input rac_textSignal]distinctUntilChanged]subscribeNext:^(id x) {
        
        [self.customerDic safeSetObject:x forKey:@"address"];
        
        //_textTag = textView.tag;
    }];
    
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
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
        
        NSLog(@"%@",customerDic);
        
       // [page2 setValue:self.productRelatedInformationArray forKey:@"productRelatedInformationArray"];
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

- (void)requestEditingData {
    
    

    
    //请求产品品牌和型号:使用请求产品品牌和型号时的viewmodel——ProductManageViewModel
    [[self.productManageViewModel requestProductBrandAndPmodelData]subscribeNext:^(NSNumber* x) {
        
        NSLog(@"dd");
    }];
    
    //请求换芯周期：使用请求产品相关信息时的viewmodel——ProductManageViewModel
    [[self.productManageViewModel requstProductInformationData]subscribeNext:^(NSNumber* x) {
        
        NSLog(@"dd");
        
    }];
    
    [[self.viewModel requestAdministratorList]subscribeNext:^(NSMutableArray*x) {
        
        NSMutableArray *administratorArray = [NSMutableArray array];
        
        for ( AMAdministrators *administrators in x) {
            
            [administratorArray addObject:[NSString stringWithFormat:@"%@          %@",administrators.nickname,administrators.username]];
            
            [self.administratorIdArray addObject:@(administrators.a_id)];
        }
        NSMutableArray *array = [NSMutableArray arrayWithObject:administratorArray];
        
        self.optionArray = [NSMutableArray arrayWithObject:array];
       // [self.optionArray replaceObjectAtIndex:1 withObject:array];
    }];
}

@end
