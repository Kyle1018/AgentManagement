//
//  AddCustomerViewControllerA.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/14.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddCustomerViewControllerA.h"
#import "CustomerManageViewModel.h"
@interface AddCustomerViewControllerA ()

@property(nonatomic,strong)PickerView *pickerView;
@property(nonatomic,strong)CustomerManageViewModel *viewModel;
@property(nonatomic,assign)NSInteger lRow;
@property(nonatomic,assign)NSInteger textTag;
@property(nonatomic,strong)PickerViewProtocol *protocol;
@property(nonatomic,strong)NSMutableDictionary *addCutomerInfoDic;

@end

@implementation AddCustomerViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _protocol = [[PickerViewProtocol alloc]init];
    
    _addCutomerInfoDic = [NSMutableDictionary dictionary];
    
    _viewModel = [[CustomerManageViewModel alloc]init];

    
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
        
        [ [self.view viewWithTag:_textTag] resignFirstResponder];
        
        self.pickerView = [PickerView showAddTo:self.view];
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
        
     
        self.pickerView.tapConfirmBlock = ^(NSString*parameter) {
            
            @strongify(self);
            UILabel *provinceLabel = [self.view viewWithTag:500];
            UILabel *cityLabel = [self.view viewWithTag:501];
            UILabel *townLabel = [self.view viewWithTag:502];

            provinceLabel.text = [ self.protocol.pickerDataArray[0]objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
            
            cityLabel.text = [ self.protocol.pickerDataArray[1]objectAtIndex:[self.pickerView.picker selectedRowInComponent:1]];
            
            townLabel.text = [ self.protocol.pickerDataArray[2]objectAtIndex:[self.pickerView.picker selectedRowInComponent:2]];

            [self.addCutomerInfoDic safeSetObject:provinceLabel.text forKey:@"province"];
            [self.addCutomerInfoDic safeSetObject:cityLabel.text forKey:@"city"];
            [self.addCutomerInfoDic safeSetObject:townLabel.text forKey:@"county"];

        };
        
    }
    else {
        
        DDLogDebug(@"点击了其它单元格");
    }
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    

    UITextField *input = [self.view viewWithTag:textField.tag];
    
    [[input rac_textSignal]subscribeNext:^(NSString * x) {
       
        if (textField.tag == 101) {//客户姓名
            
            [self.addCutomerInfoDic safeSetObject:x forKey:@"name"];
        }
        
        else if (textField.tag == 102) {//手机号
            
            [self.addCutomerInfoDic safeSetObject:x forKey:@"phone" ];
        }
        else if (textField.tag == 103) {//tds
            
            [self.addCutomerInfoDic safeSetObject:x forKey:@"tds"];
            
        }
        else if (textField.tag == 104) {//ph
            
            [self.addCutomerInfoDic safeSetObject:x forKey:@"ph"];
            
        }
        else if (textField.tag == 105) {//硬度
            
            [self.addCutomerInfoDic safeSetObject:x forKey:@"hardness"];
            
        }
        else if (textField.tag == 106) {//余氯值
            [self.addCutomerInfoDic safeSetObject:x forKey:@"chlorine"];
            
        }
        _textTag = textField.tag;
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
    __weak typeof(self) weakSelf = self;
    
    [[input rac_textSignal]subscribeNext:^(id x) {
       
        [weakSelf.addCutomerInfoDic safeSetObject:x forKey:@"address"];
        
        _textTag = textView.tag;
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier compare:@"AddCustomerBSegue"]==NO) {
        
        id page2=segue.destinationViewController;
    
        [page2 setValue:self.addCutomerInfoDic forKey:@"addCutomerInfoDic"];
    }
    
}

@end
