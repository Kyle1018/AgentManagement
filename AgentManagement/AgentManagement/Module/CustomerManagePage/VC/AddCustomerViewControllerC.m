//
//  AddCustomerViewControllerC.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/16.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddCustomerViewControllerC.h"
#import "CustomerManageViewModel.h"
#import "AMSales.h"
#import "AMAdministrators.h"
#import "AMCustomer.h"
@interface AddCustomerViewControllerC ()
@property(nonatomic,strong)PickerView *pickerView;
@property(nonatomic,strong)CustomerManageViewModel *viewModel;
@property(nonatomic,strong)NSMutableArray*salersIdArray;
@property(nonatomic,strong)NSMutableArray *administratorIdArray;
@property(nonatomic,strong)NSMutableArray *optionArray;
@property(nonatomic,assign)NSInteger indexRow;
@property(nonatomic,strong)PickerViewProtocol *protocol;
@end

@implementation AddCustomerViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _protocol = [[PickerViewProtocol alloc]init];
    
    _salersIdArray = [NSMutableArray array];
    
    _administratorIdArray = [NSMutableArray array];
    
    _optionArray = [NSMutableArray arrayWithObjects:@"销售",@"管理", nil];
    
    [self requestData];
}

- (void)requestData {
    
    _viewModel = [[CustomerManageViewModel alloc]init];
    
    DDLogDebug(@"%@",self.addCutomerInfoDic);
    
    [[self.viewModel requstSalersList]subscribeNext:^(NSMutableArray* x) {
        
        NSMutableArray *salersArray = [NSMutableArray array];
        
        for ( AMSales *sales in x) {
            
            [salersArray addObject:[NSString stringWithFormat:@"%@          %@",sales.name,sales.phone]];
            
            [self.salersIdArray addObject:@(sales.s_id)];
         
        }
        
        NSMutableArray *array = [NSMutableArray arrayWithObject:salersArray];
        
        [_optionArray replaceObjectAtIndex:0 withObject:array];
        
    }];
    
    [[self.viewModel requestAdministratorList]subscribeNext:^(NSMutableArray*x) {
        
        NSMutableArray *administratorArray = [NSMutableArray array];
        
        for ( AMAdministrators *administrators in x) {
            
            [administratorArray addObject:[NSString stringWithFormat:@"%@          %@",administrators.nickname,administrators.username]];
            
            [self.administratorIdArray addObject:@(administrators.a_id)];
        }
         NSMutableArray *array = [NSMutableArray arrayWithObject:administratorArray];
        
        [_optionArray replaceObjectAtIndex:1 withObject:array];
    }];
}

#pragma mark -tableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self.pickerView = [PickerView showAddTo:[UIApplication sharedApplication].keyWindow];
    self.pickerView.picker.delegate = self.protocol;
    self.pickerView.picker.dataSource = self.protocol;
    
    self.protocol.pickerDataArray = self.optionArray[indexPath.row];
     [self.pickerView.picker reloadAllComponents];

    @weakify(self);
    _pickerView.tapConfirmBlock = ^() {
        
        @strongify(self);
        
        UILabel *label = [tableView viewWithTag:1000+indexPath.row];
    
        label.text=[[self.optionArray[indexPath.row]objectAtIndex:0]objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
        
        if (indexPath.row == 0) {

            NSNumber* salersId = [self.salersIdArray objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
            
            [self.addCutomerInfoDic safeSetObject:salersId forKey:@"s_id"];
        }
        else {

             NSNumber* administratorsId = [self.administratorIdArray objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
            
            [self.addCutomerInfoDic safeSetObject:administratorsId forKey:@"a_id"];
        }
    };
}



#pragma mark - Action
- (IBAction)saveAction:(UIButton *)sender {
    
    //添加客户请求
    [[[self.viewModel requstAddCustomerData:self.addCutomerInfoDic]filter:^BOOL(id value) {
        
        if ([value isKindOfClass:[AMCustomer class]]) {
            
            return YES;
        }
        else {
            
            [MBProgressHUD showText:@"添加用户失败"];
             return NO;
        }
     
        
    }]subscribeNext:^(AMCustomer* x) {
        
         [self.navigationController popToRootViewControllerAnimated:YES];
    }];
   

    
}

@end
