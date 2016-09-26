//
//  AddCustomerViewControllerB.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/16.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddCustomerViewControllerB.h"
#import "ProductManageViewModel.h"

@interface AddCustomerViewControllerB ()
@property(nonatomic,strong)ProductManageViewModel *viewModel;

@property(nonatomic,strong)PickerView *pickerView;
@property(nonatomic,assign)NSInteger indexRow;
@property(nonatomic,strong)NSMutableArray *pickerDataArray;
@property(nonatomic,strong)NSMutableArray *brandAndModelArray;
@property(nonatomic,strong)PickerDataView *datePicker;
@property(nonatomic,copy)NSString *dateStr;
@property(nonatomic,strong)NSMutableArray *orderArray;//订单数组

@property(nonatomic,strong)NSMutableDictionary *orderDic;//订单模型
@property(nonatomic,strong)PickerViewProtocol *protocol;
@end

@implementation AddCustomerViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];

    _brandAndModelArray = [NSMutableArray array];
    
    _orderArray = [NSMutableArray array];
    
    _orderDic = [NSMutableDictionary dictionary];
    
    _protocol = [[PickerViewProtocol alloc]init];

    [self requestData];

    DDLogDebug(@"%@",self.addCutomerInfoDic);

}

- (void)requestData {
    
    _viewModel = [[ProductManageViewModel alloc]init];
    
    _pickerDataArray = [NSMutableArray arrayWithObjects:@"购买机型",@"购买时间",@"安装时间",@"换芯周期", nil];
    
    //请求产品品牌和型号:使用请求产品品牌和型号时的viewmodel——ProductManageViewModel
    [[self.viewModel requestProductBrandAndPmodelData]subscribeNext:^(id x) {
    
        if ([x isKindOfClass:[NSMutableArray class]]) {
            
            [x removeObjectAtIndex:1];
            
            self.brandAndModelArray = x;
            
            NSMutableArray *array = [NSMutableArray arrayWithObjects:x[0], [x[1]objectAtIndex:0],nil];
            
            [self.pickerDataArray replaceObjectAtIndex:0 withObject:array];
        }
       
    }];
    
    //请求换芯周期：使用请求产品相关信息时的viewmodel——ProductManageViewModel
    [[self.viewModel requstProductInformationData]subscribeNext:^(id x) {
        
        if ([x isKindOfClass:[NSMutableArray class]]) {
            
            NSMutableArray *cycleArray = [NSMutableArray arrayWithArray:[[x lastObject]lastObject]];
            
            NSMutableArray *array = [NSMutableArray arrayWithObject:cycleArray];
            
            [self.pickerDataArray replaceObjectAtIndex:3 withObject:array];
            
        }

     
    }];
    
}


#pragma mark -UITabelViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (indexPath.row == 0 || indexPath.row == 3) {
        
        self.pickerView = [PickerView showAddTo:[UIApplication sharedApplication].keyWindow];
        self.pickerView.picker.delegate = self.protocol;
        self.pickerView.picker.dataSource = self.protocol;
        
        self.protocol.pickerDataArray = self.pickerDataArray[indexPath.row];
        
        [self.protocol.pickerDataArrayB removeAllObjects];
        
        if ([self.pickerDataArray[indexPath.row] count]>1) {
            
            self.protocol.pickerDataArrayB = self.brandAndModelArray[1];
        }
        [self.pickerView.picker reloadAllComponents];
 
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
        
        _datePicker = [PickerDataView showDateAddTo:[UIApplication sharedApplication].keyWindow];
      
        _dateStr = [NSString getDateStr:_datePicker.datePicker.date];
        
        [[_datePicker.datePicker rac_signalForControlEvents:UIControlEventValueChanged]subscribeNext:^(UIDatePicker* x) {

            self.dateStr=[NSString getDateStr:x.date];
            
        }];
        
        @weakify(self);
        _datePicker.tapConfirmBlock = ^() {
            
            @strongify(self);
            
            UILabel *label = [tableView viewWithTag:2000+indexPath.row];
            
            label.text =  self.dateStr;
            
         
            
            if (label.tag == 2001) {

                NSString *date = [NSString stringWithFormat:@"%@",self.datePicker.datePicker.date];
                
                [self.orderDic safeSetObject:date forKey:@"buy_time"];
                
            }
            else if (label.tag == 2002) {
                
                NSString *date = [NSString stringWithFormat:@"%@",self.datePicker.datePicker.date];
                
                [self.orderDic safeSetObject:date forKey:@"install_time"];
            }
            
        };
    }
    
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
