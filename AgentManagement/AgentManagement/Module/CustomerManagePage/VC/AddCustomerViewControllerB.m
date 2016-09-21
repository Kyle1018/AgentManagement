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
    
    [self observeData];
    
    DDLogDebug(@"%@",self.addCutomerInfoDic);

}

- (void)requestData {
    
    _viewModel = [[ProductManageViewModel alloc]init];
    
    _pickerDataArray = [NSMutableArray arrayWithObjects:@"购买机型",@"购买时间",@"安装时间",@"换芯周期", nil];
    
    //请求产品品牌和型号:使用请求产品品牌和型号时的viewmodel——ProductManageViewModel
    [[self.viewModel requestProductBrandAndPmodelData]subscribeNext:^(NSNumber* x) {
    
       
    }];
    
    //请求换芯周期：使用请求产品相关信息时的viewmodel——ProductManageViewModel
    [[self.viewModel requstProductInformationData]subscribeNext:^(NSNumber* x) {

     
  
    }];
    
}

- (void)observeData {
    
    [RACObserve(self.viewModel, productAndModelArray)subscribeNext:^(NSMutableArray* x) {
       
        [x removeObjectAtIndex:1];
        
        self.brandAndModelArray = x;
        
        NSMutableArray *array = [NSMutableArray arrayWithObjects:x[0], [x[1]objectAtIndex:0],nil];
        
        [self.pickerDataArray replaceObjectAtIndex:0 withObject:array];
    }];
    
    [RACObserve(self.viewModel, productRelatedInformationArray)subscribeNext:^(id x) {
        
        NSMutableArray *cycleArray = [NSMutableArray arrayWithArray:[[x lastObject]lastObject]];
        
        NSMutableArray *array = [NSMutableArray arrayWithObject:cycleArray];
        
        [self.pickerDataArray replaceObjectAtIndex:3 withObject:array];
    }];
}

#pragma mark -UITabelViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
    if (indexPath.row == 0 || indexPath.row == 3) {
        
        _pickerView = [PickerView showAddTo:self.view];
        _pickerView.picker.delegate = self;
        _pickerView.picker.dataSource = self;
        _indexRow = indexPath.row;
        
        @weakify(self);
        
        _pickerView.tapConfirmBlock = ^() {
            
            @strongify(self)
            
            for (int i =0; i<[self.pickerView.picker numberOfComponents]; i++) {
                
                UILabel *label = [tableView viewWithTag:1000+indexPath.row+i];
                
                NSString *str = [[self.pickerDataArray[indexPath.row]objectAtIndex:i]objectAtIndex:[self.pickerView.picker selectedRowInComponent:i]];
                label.text = str;
                
                
                if (label.tag == 1000) {
                    
                    [self.orderDic safeSetObject:str forKey:@"brand"];

                }
                else if (label.tag == 1001) {
                    
                    [self.orderDic safeSetObject:str forKey:@"pmodel"];
                }
                else if (label.tag == 1003) {
                    
                    [self.orderDic safeSetObject:str forKey:@"cycle"];
                    
                }
            }
            
        };
    }
    
    else {
        
        _datePicker = [PickerDataView showDateAddTo:self.view];
      
        _dateStr = [_datePicker getDateStr:_datePicker.datePicker.date];
        
        [[_datePicker.datePicker rac_signalForControlEvents:UIControlEventValueChanged]subscribeNext:^(UIDatePicker* x) {

            self.dateStr=[self.datePicker getDateStr:x.date];
            
        }];
        
        @weakify(self);
        _datePicker.tapConfirmBlock = ^() {
            
            @strongify(self);
            
            UILabel *label = [tableView viewWithTag:2000+indexPath.row];
            
            label.text =  self.dateStr;
            
            if (label.tag == 2001) {
                
               // NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[self.datePicker.datePicker.date timeIntervalSince1970]];
               // NSLog(@"timeSp:%@",timeSp); //时间戳的值
                  NSTimeInterval timeSp = [self.datePicker.datePicker.date timeIntervalSince1970];
                
                NSLog(@"%@",self.datePicker.datePicker.date);
                
                [self.orderDic safeSetObject:@(timeSp) forKey:@"buy_time"];
                
            }
            else if (label.tag == 2002) {
                
                NSTimeInterval timeSp = [self.datePicker.datePicker.date timeIntervalSince1970];
              //  NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[self.datePicker.datePicker.date timeIntervalSince1970]];
//                NSLog(@"timeSp:%@",timeSp); //时间戳的值
//                NSLog(@"%@",self.datePicker.datePicker.date);

                
                [self.orderDic safeSetObject:@(timeSp) forKey:@"install_time"];
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
        
        /*
         brand = ".bobnonl";
         "buy_time" = "2016\U5e7409\U670820\U65e5";
         cycle = "1\U4e2a\U6708";
         "install_time" = "2016\U5e7409\U670820\U65e5";
         pmodel = jvjvbk;
         }
         */
        
        [self.orderArray addObject:self.orderDic];
        
        [self.addCutomerInfoDic safeSetObject:self.orderArray forKey:@"order"];
        
        [page2 setValue:self.addCutomerInfoDic forKey:@"addCutomerInfoDic"];
    }
    
}

@end
