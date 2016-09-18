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

@end

@implementation AddCustomerViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel = [[CustomerManageViewModel alloc]init];
    
    DDLogDebug(@"%@",self.addCutomerInfoDic);
    // Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    __weak typeof(self) weakSelf = self;
//    
//    _pickerView = [PickerView showAddTo:self.view];
//    _pickerView.picker.delegate = self;
//    _pickerView.picker.dataSource = self;
//   // _indexRow = indexPath.row;
//    
//    _pickerView.tapConfirmBlock = ^() {
//        
//        for (int i =0; i<[weakSelf.pickerView.picker numberOfComponents]; i++) {
//            
////            UILabel *label = [tableView viewWithTag:1000+indexPath.row+i];
////            
////            NSString *str = [[weakSelf.pickerDataArray[indexPath.row]objectAtIndex:i]objectAtIndex:[weakSelf.pickerView.picker selectedRowInComponent:i]];
////            
////            label.text = str;
//        }
//        
//    };
//    
    
}
- (IBAction)saveAction:(UIButton *)sender {
    
    [[self.viewModel requstAddCustomerData:self.addCutomerInfoDic]subscribeNext:^(id x) {
        
    }];
    
}

@end
