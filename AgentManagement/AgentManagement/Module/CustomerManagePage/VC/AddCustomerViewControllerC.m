//
//  AddCustomerViewControllerC.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/16.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddCustomerViewControllerC.h"
#import "PickerView.h"
#import "CustomerManageViewModel.h"
@interface AddCustomerViewControllerC ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)PickerView *pickerView;
@property(nonatomic,strong)CustomerManageViewModel *viewModel;
@property(nonatomic,strong)NSMutableArray*salersNameArray;
@property(nonatomic,strong)NSMutableArray *administratorNameArray;
@property(nonatomic,assign)NSInteger indexRow;
@end

@implementation AddCustomerViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
}

- (void)requestData {
    
    _viewModel = [[CustomerManageViewModel alloc]init];
    
    DDLogDebug(@"%@",self.addCutomerInfoDic);
    
    [[self.viewModel requstSalersName]subscribeNext:^(NSMutableArray* x) {
        
        self.salersNameArray = x;
        
    }];
    
    [[self.viewModel requestAdministratorName]subscribeNext:^(NSMutableArray*x) {
        
        self.administratorNameArray = x;
    }];
}

#pragma mark -tableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    _pickerView = [PickerView showAddTo:self.tableView];
    _pickerView.picker.delegate = self;
    _pickerView.picker.dataSource = self;
    _indexRow = indexPath.row;
    
    @weakify(self);
    _pickerView.tapConfirmBlock = ^() {
        
        @strongify(self);
        
        UILabel *label = [tableView viewWithTag:1000+indexPath.row];

        label.text = indexPath.row == 0?[self.salersNameArray objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]]:[self.administratorNameArray objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
        
        if (indexPath.row == 0) {
            
            [self.addCutomerInfoDic safeSetObject:label.text forKey:@"s_id"];
        }
        else {
            
            [self.addCutomerInfoDic safeSetObject:label.text forKey:@"a_id"];
        }
    };
}

#pragma pickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return _indexRow == 0?self.salersNameArray.count:self.administratorNameArray.count;
  
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return _indexRow==0?[self.salersNameArray objectAtIndex:row]:[self.administratorNameArray objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 42;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return ScreenWidth/2;
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

#pragma mark - Action
- (IBAction)saveAction:(UIButton *)sender {
    
    //添加客户请求
    [[self.viewModel requstAddCustomerData:self.addCutomerInfoDic]subscribeNext:^(id x) {
        
        
    }];
    
}

@end
