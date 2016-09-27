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
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property(nonatomic,strong)RACSignal *signUpActiveSignal;
@end

@implementation AddCustomerViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _protocol = [[PickerViewProtocol alloc]init];
    
    _addCutomerInfoDic = [NSMutableDictionary dictionary];
    
    _viewModel = [[CustomerManageViewModel alloc]init];
    
    [self signal];
}

- (void)signal {
    
    RACSignal *textFieldSignal=[[[self.textField rac_textSignal]distinctUntilChanged]map:^id(NSString* value) {
        
        return @(value.length>0);
    }];
    
    RACSignal *textViewSignal = [[[self.textView rac_textSignal]distinctUntilChanged]map:^id(NSString* value) {
        
        return @(value.length>0);
    }];
    
    _signUpActiveSignal =
    [RACSignal combineLatest:@[textFieldSignal,textViewSignal]
                      reduce:^id(NSNumber*a,NSNumber*b){
                          
                          return @([a boolValue]&&[b boolValue]&&[@(self.addressLabel.text.length>0)boolValue]);
                      }];
    
    
    RAC(self.nextButton,enabled) = [_signUpActiveSignal map:^id(id value) {
        
        if ([value boolValue]) {
            
            [self.nextButton setTitleColor:[UIColor colorWithHex:@"47b6ff"] forState:UIControlStateNormal];
            
        }
        else {
            
            [self.nextButton setTitleColor:[UIColor colorWithHex:@"9b9b9b"] forState:UIControlStateNormal];
            
        }
        
        return value;
    }];

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
        
        [[self.view viewWithTag:_textTag] resignFirstResponder];
                
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
        
            NSString*province = [ self.protocol.pickerDataArray[0]objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
            
            NSString*city= [ self.protocol.pickerDataArray[1]objectAtIndex:[self.pickerView.picker selectedRowInComponent:1]];
            
            NSString*county = [ self.protocol.pickerDataArray[2]objectAtIndex:[self.pickerView.picker selectedRowInComponent:2]];

            [self.addCutomerInfoDic safeSetObject:province forKey:@"province"];
            [self.addCutomerInfoDic safeSetObject:city forKey:@"city"];
            [self.addCutomerInfoDic safeSetObject:county forKey:@"county"];
            
            NSString *address = [NSString stringWithFormat:@"%@市",province];
            
            NSString *str = @"";
            
            if ([address isEqualToString:city]) {
                
                str = [NSString stringWithFormat:@"%@%@",city,county];
                
            }
            else {
                
                str = [NSString stringWithFormat:@"%@%@%@",province,city,county];
                
            }
            
            self.addressLabel.text = str;
            
            [self.signUpActiveSignal subscribeNext:^(NSNumber* x) {
                
                if ([x boolValue]) {
                    
                    self.nextButton.enabled = YES;
                    [self.nextButton setTitleColor:[UIColor colorWithHex:@"47b6ff"] forState:UIControlStateNormal];

                }
                else {
                    
                    self.nextButton.enabled = NO;
                    [self.nextButton setTitleColor:[UIColor colorWithHex:@"9b9b9b"] forState:UIControlStateNormal];
                }
            }];
            
     
   
        };

    }
    
    else if (indexPath.section==0 && indexPath.row==3) {
        
        self.textView.editable = YES;
        self.textView.selectable = YES;
        [self.textView becomeFirstResponder];
        
        [[self.textView rac_textSignal]subscribeNext:^(id x) {
            
            [self.addCutomerInfoDic safeSetObject:x forKey:@"address"];
            
            _textTag = self.textView.tag;
        }];

    }
    else {
        
        DDLogDebug(@"点击了其它单元格");
     
        NSString *tagStr = [NSString stringWithFormat:@"1%ld%ld",indexPath.section,indexPath.row];
        UITextField *textField = [self.view viewWithTag:[tagStr integerValue]];
        textField.enabled = YES;
        [textField becomeFirstResponder];

        [[[textField rac_textSignal]distinctUntilChanged]subscribeNext:^(id x) {
            
            if (indexPath.section==0) {
                
                switch (indexPath.row) {
                    case 0:
                        [self.addCutomerInfoDic safeSetObject:x forKey:@"name"];
                        break;
                    case 1:
                        [self.addCutomerInfoDic safeSetObject:x forKey:@"phone"];
                        break;
                        
                    default:
                        break;
                }
            }
            else {
                
                switch (indexPath.row) {
                    case 0:
                        [self.addCutomerInfoDic safeSetObject:x forKey:@"tds"];
                        break;
                    case 1:
                        [self.addCutomerInfoDic safeSetObject:x forKey:@"ph"];
                        break;
                    case 2:
                        [self.addCutomerInfoDic safeSetObject:x forKey:@"hardness"];
                        break;
                    case 3:
                        [self.addCutomerInfoDic safeSetObject:x forKey:@"chlorine"];
                        break;
                        
                    default:
                        break;
                }
            }
            
            _textTag = textField.tag;
            
        }];

    }
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark -UITextViewDelegate

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
