//
//  AddCustomerViewControllerB.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/16.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddCustomerViewControllerB.h"
#import "PickerView.h"
#import "ProductManageViewModel.h"
@interface AddCustomerViewControllerB ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)ProductManageViewModel *viewModel;
@property(nonatomic,strong)NSMutableArray *brandAndModelArray;
@property(nonatomic,strong)PickerView *pickerView;
@property(nonatomic,assign)NSInteger indexRow;
@property(nonatomic,strong)NSMutableArray *pickerDataArray;
@property(nonatomic,strong)PickerDataView *datePicker;
@property(nonatomic,copy)NSString *dateStr;
@property(nonatomic,strong)NSMutableArray *orderArray;//订单数组

@property(nonatomic,strong)NSMutableDictionary *orderDic;//订单模型

@end

@implementation AddCustomerViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];

    _brandAndModelArray = [NSMutableArray array];
    
    _orderArray = [NSMutableArray array];
    
    _orderDic = [NSMutableDictionary dictionary];

    [self requestData];
    
    NSLog(@"%@",self.addCutomerInfoDic);

}

- (void)requestData {
    
    __weak typeof(self) weakSelf = self;
    
    _viewModel = [[ProductManageViewModel alloc]init];
    
    _pickerDataArray = [NSMutableArray arrayWithObjects:@"购买机型",@"购买时间",@"安装时间",@"换芯周期", nil];
    
    //请求产品品牌和型号:使用请求产品品牌和型号时的viewmodel——ProductManageViewModel
    [[self.viewModel requestProductBrandAndPmodelData]subscribeNext:^(NSMutableArray* x) {
       
        [x removeObjectAtIndex:1];
        
        weakSelf.brandAndModelArray = x;
        
        NSMutableArray *array = [NSMutableArray arrayWithObjects:x[0], [x[1]objectAtIndex:0],nil];
        
        [weakSelf.pickerDataArray replaceObjectAtIndex:0 withObject:array];
       
    }];
    
    //请求换芯周期：使用请求产品相关信息时的viewmodel——ProductManageViewModel
    [[self.viewModel requstProductInformationData]subscribeNext:^(NSMutableArray* x) {

        NSMutableArray *cycleArray = [NSMutableArray arrayWithArray:[[x lastObject]lastObject]];
        
        NSMutableArray *array = [NSMutableArray arrayWithObject:cycleArray];
        
        [weakSelf.pickerDataArray replaceObjectAtIndex:3 withObject:array];
  
    }];
    
}


#pragma mark -UITabelViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    
    if (indexPath.row == 0 || indexPath.row == 3) {
        
        _pickerView = [PickerView showAddTo:self.view];
        _pickerView.picker.delegate = self;
        _pickerView.picker.dataSource = self;
        _indexRow = indexPath.row;
        
        _pickerView.tapConfirmBlock = ^() {
            
            for (int i =0; i<[weakSelf.pickerView.picker numberOfComponents]; i++) {
                
                UILabel *label = [tableView viewWithTag:1000+indexPath.row+i];
                
                NSString *str = [[weakSelf.pickerDataArray[indexPath.row]objectAtIndex:i]objectAtIndex:[weakSelf.pickerView.picker selectedRowInComponent:i]];
                label.text = str;
                
                
                if (label.tag == 1000) {
                    
                    [weakSelf.orderDic safeSetObject:str forKey:@"brand"];

                }
                else if (label.tag == 1001) {
                    
                    [weakSelf.orderDic safeSetObject:str forKey:@"pmodel"];
                }
                else if (label.tag == 1003) {
                    
                    [weakSelf.orderDic safeSetObject:str forKey:@"cycle"];
                    
                }
            }
            
        };
    }
    
    else {
        
        _datePicker = [PickerDataView showDateAddTo:self.view];
      
        _dateStr = [_datePicker getDateStr:_datePicker.datePicker.date];
        
        [[_datePicker.datePicker rac_signalForControlEvents:UIControlEventValueChanged]subscribeNext:^(UIDatePicker* x) {

            weakSelf.dateStr=[weakSelf.datePicker getDateStr:x.date];
            
        }];
        
        _datePicker.tapConfirmBlock = ^() {
            
            UILabel *label = [tableView viewWithTag:2000+indexPath.row];
            
            label.text =  weakSelf.dateStr;
            
            if (label.tag == 2001) {
                
                [weakSelf.orderDic safeSetObject:weakSelf.dateStr forKey:@"buy_time"];
                
            }
            else if (label.tag == 2002) {
                
                [weakSelf.orderDic safeSetObject:weakSelf.dateStr forKey:@"install_time"];
            }
            
        };
    }
    
}

#pragma pickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return [self.pickerDataArray[_indexRow] count];
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
   return [[self.pickerDataArray[_indexRow] objectAtIndex:component]count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

   return  [[self.pickerDataArray[_indexRow]objectAtIndex:component]objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 42;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {

     return ScreenWidth/2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (_indexRow==0) {
        
        if (component==0) {
            
            [self.pickerDataArray[_indexRow]replaceObjectAtIndex:1 withObject: [_brandAndModelArray[1]objectAtIndex:row]];
            
            [pickerView selectedRowInComponent:1];
            [pickerView reloadComponent:1];
        }
        
        else {
            
            
        }
        
    }
    
    else {
        
        [self.pickerDataArray[_indexRow][component]objectAtIndex:row];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:17]];
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

//进入添加产品页面
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier compare:@"AddCustomerCSegue"]==NO) {
        
        id page2=segue.destinationViewController;
        
        [self.orderArray addObject:self.orderDic];
        
        [self.addCutomerInfoDic safeSetObject:self.orderArray forKey:@"order"];
        
        [page2 setValue:self.addCutomerInfoDic forKey:@"addCutomerInfoDic"];
    }
    
}

@end
