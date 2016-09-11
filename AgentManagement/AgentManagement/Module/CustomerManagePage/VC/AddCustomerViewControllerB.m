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

@end

@implementation AddCustomerViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _brandAndModelArray = [NSMutableArray array];
//    _brandArray = [NSMutableArray array];
//    _pmodelArray = [NSMutableArray array];
//    _cycle = [NSMutableArray array];
    
    
    [self requestData];

}

- (void)requestData {
    
    __weak typeof(self) weakSelf = self;
    
    _viewModel = [[ProductManageViewModel alloc]init];
    
    _pickerDataArray = [NSMutableArray arrayWithObjects:@"购买机型",@"购买时间",@"安装时间",@"换芯周期", nil];
    
    //请求产品品牌和型号:使用请求产品品牌和型号时的viewmodel——ProductManageViewModel
    [[self.viewModel requestProductBrandAndPmodelData]subscribeNext:^(NSMutableArray* x) {
       
        [x removeObjectAtIndex:1];
        
        _brandAndModelArray = x;
        
        NSMutableArray *array = [NSMutableArray arrayWithObjects:x[0], [x[1]objectAtIndex:0],nil];
        
        [_pickerDataArray replaceObjectAtIndex:0 withObject:array];
       
    }];
    
    //请求换芯周期：使用请求产品相关信息时的viewmodel——ProductManageViewModel
    [[self.viewModel requstProductInformationData]subscribeNext:^(NSMutableArray* x) {

        NSMutableArray *cycleArray = [NSMutableArray arrayWithArray:[[x lastObject]lastObject]];
        
        NSMutableArray *array = [NSMutableArray arrayWithObject:cycleArray];
        
        [_pickerDataArray replaceObjectAtIndex:3 withObject:array];
  
    }];
    
}


#pragma mark -UITabelViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section==0 && indexPath.row==2) {
//        
//        NSLog(@"点击了客户地址单元格");
//
    if (indexPath.row == 0 || indexPath.row == 3) {
        
        __weak typeof(self) weakSelf = self;
        _pickerView = [PickerView showAddTo:self.view];
        _pickerView.picker.delegate = self;
        _pickerView.picker.dataSource = self;
        
        _indexRow = indexPath.row;
    }
    
    else {
        
        _pickerView = [PickerView showDateAddTo:self.view];
        
    }
    
//
//        _pickerView.tapConfirmBlock = ^() {
//            
//            UILabel *provinceLabel = [weakSelf.view viewWithTag:500];
//            UILabel *cityLabel = [weakSelf.view viewWithTag:501];
//            UILabel *townLabel = [weakSelf.view viewWithTag:502];
//            
//            provinceLabel.text = [weakSelf.areaDic[@"province"]objectAtIndex:[weakSelf.pickerView.picker selectedRowInComponent:0]];
//            
//            cityLabel.text = [weakSelf.areaDic[@"city"]objectAtIndex:[weakSelf.pickerView.picker selectedRowInComponent:1]];
//            
//            townLabel.text = [weakSelf.areaDic[@"district"]objectAtIndex:[weakSelf.pickerView.picker selectedRowInComponent:2]];
//            
//            [weakSelf.addCutomerInfoDic safeSetObject:provinceLabel.text forKey:@"province"];
//            [weakSelf.addCutomerInfoDic safeSetObject:cityLabel.text forKey:@"city"];
//            [weakSelf.addCutomerInfoDic safeSetObject:townLabel.text forKey:@"county"];
//            
//        };
//        
//    }
//    else {
//        
//        NSLog(@"点击了其它单元格");
//    }
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
    __weak typeof(self) weakSelf = self;
    
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

@end
