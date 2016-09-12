//
//  AddCustomerViewControllerA.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/14.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddCustomerViewControllerA.h"
#import "PickerView.h"
#import "CustomerManageViewModel.h"
@interface AddCustomerViewControllerA ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)PickerView *pickerView;
@property(nonatomic,strong)CustomerManageViewModel *viewModel;
@property(nonatomic,strong)NSMutableDictionary *areaDic;
@property(nonatomic,assign)NSInteger lRow;

@property(nonatomic,strong)NSMutableDictionary *addCutomerInfoDic;
@end

@implementation AddCustomerViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];

    [self requestData];
    
    //[self signal];
    
    _addCutomerInfoDic = [NSMutableDictionary dictionary];
}

- (void)requestData {
    
      __weak typeof(self) weakSelf = self;
    _viewModel = [[CustomerManageViewModel alloc]init];
    
    [[self.viewModel requestAreaListData:0 lIndex:0]subscribeNext:^(NSDictionary* x) {
       
        weakSelf.areaDic = [NSMutableDictionary dictionaryWithDictionary:x];
        
    }];

}


#pragma pickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return [self.areaDic[@"province"] count];
    } else if (component == 1) {
        return [self.areaDic[@"city"] count];
    } else {
        return [self.areaDic[@"district"] count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.areaDic[@"province"]objectAtIndex:row];
    } else if (component == 1) {
        return [self.areaDic[@"city"]objectAtIndex:row];
    } else {
        return [self.areaDic[@"district"] objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 42;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return ScreenWidth/3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
      __weak typeof(self) weakSelf = self;
    
    if (component == 0) {
      
        [[self.viewModel requestAreaListData:row lIndex:0]subscribeNext:^(NSDictionary* x) {
           
            [weakSelf.areaDic removeAllObjects];
            
            [weakSelf.areaDic setDictionary:x];
            
        }];

        _lRow = row;

    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        
        [[self.viewModel requestAreaListData:_lRow lIndex:row]subscribeNext:^(id x) {
            
            [weakSelf.areaDic removeAllObjects];
            [weakSelf.areaDic setDictionary:x];
            [pickerView selectRow:1 inComponent:2 animated:YES];
            
        }];

    }
    
    [pickerView reloadComponent:2];
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


#pragma mark -UITabelViewDatasource/Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section ==0) {
        
        return 10;
    }
    else {
        
        return 24;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0 && indexPath.row==2) {
        
        NSLog(@"点击了客户地址单元格");
        
        __weak typeof(self) weakSelf = self;
        _pickerView = [PickerView showAddTo:self.view];
        _pickerView.picker.delegate = self;
        _pickerView.picker.dataSource = self;
        
        _pickerView.tapConfirmBlock = ^(NSString*parameter) {
            
            UILabel *provinceLabel = [weakSelf.view viewWithTag:500];
            UILabel *cityLabel = [weakSelf.view viewWithTag:501];
            UILabel *townLabel = [weakSelf.view viewWithTag:502];
            
            provinceLabel.text = [weakSelf.areaDic[@"province"]objectAtIndex:[weakSelf.pickerView.picker selectedRowInComponent:0]];
            
            cityLabel.text = [weakSelf.areaDic[@"city"]objectAtIndex:[weakSelf.pickerView.picker selectedRowInComponent:1]];
            
            townLabel.text = [weakSelf.areaDic[@"district"]objectAtIndex:[weakSelf.pickerView.picker selectedRowInComponent:2]];
            
            [weakSelf.addCutomerInfoDic safeSetObject:provinceLabel.text forKey:@"province"];
            [weakSelf.addCutomerInfoDic safeSetObject:cityLabel.text forKey:@"city"];
            [weakSelf.addCutomerInfoDic safeSetObject:townLabel.text forKey:@"county"];

        };
        
    }
    else {
        
        NSLog(@"点击了其它单元格");
    }
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
      __weak typeof(self) weakSelf = self;

    UITextField *input = [self.view viewWithTag:textField.tag];
    
    [[input rac_textSignal]subscribeNext:^(NSString * x) {
       
        if (textField.tag == 101) {//客户姓名
            
            [weakSelf.addCutomerInfoDic safeSetObject:x forKey:@"name"];
        }
        
        else if (textField.tag == 102) {//手机号
            
            [weakSelf.addCutomerInfoDic safeSetObject:x forKey:@"phone" ];
        }
        else if (textField.tag == 103) {//tds
            
            [weakSelf.addCutomerInfoDic safeSetObject:x forKey:@"tds"];
            
        }
        else if (textField.tag == 104) {//ph
            
            [weakSelf.addCutomerInfoDic safeSetObject:x forKey:@"ph"];
            
        }
        else if (textField.tag == 105) {//硬度
            
            [weakSelf.addCutomerInfoDic safeSetObject:x forKey:@"hardness"];
            
        }
        else if (textField.tag == 106) {//余氯值
            [weakSelf.addCutomerInfoDic safeSetObject:x forKey:@"chlorine"];
            
        }
        NSLog(@"_________________%@",x);
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
    __weak typeof(self) weakSelf = self;
    
    [[input rac_textSignal]subscribeNext:^(id x) {
       
        [weakSelf.addCutomerInfoDic safeSetObject:x forKey:@"address"];
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

#pragma mark - Segue
//进入添加产品页面
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier compare:@"AddCustomerBSegue"]==NO) {
        
        id page2=segue.destinationViewController;
    
        [page2 setValue:self.addCutomerInfoDic forKey:@"addProductInfoDic"];
    }
    
}

@end
