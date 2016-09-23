//
//  CSearchMenuViewController.m
//  AgentManagement
//
//  Created by huabin on 16/8/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CSearchMenuViewController.h"
#import "CSearchMenuCell.h"
#import "CustomerManageViewModel.h"

@interface CSearchMenuViewController()

@property (strong, nonatomic) IBOutlet UIView *bgView;//背景视图

@property (strong, nonatomic) IBOutlet UIView *cancleView;//取消视图

@property(nonatomic,strong)CustomerManageViewModel *viewModel;

@property(nonatomic,strong)NSMutableDictionary *areaDic;

@property(nonatomic,assign)NSInteger lRow;

@property(nonatomic,assign)NSInteger textTag;

@property(nonatomic,strong)PickerView *pickerView;

@property (weak, nonatomic) IBOutlet UITableView *searchMenuTabelView;

@property(nonatomic,strong)NSMutableDictionary *selectedOptionDic;

@property(nonatomic,strong)PickerViewProtocol *protocol;

@end

@implementation CSearchMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.bgView.originX = ScreenWidth;
    
    [self.cancleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenuView)]];
    
    _selectedOptionDic = [NSMutableDictionary dictionary];
    
    _protocol = [[PickerViewProtocol alloc]init];
    
     _viewModel = [[CustomerManageViewModel alloc]init];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:1 animations:^{
        
        self.bgView.originX = 75;
        
    }];
}

- (void)hideMenuView {
    
    [UIView animateWithDuration:1 animations:^{
        
        self.bgView.originX = ScreenWidth;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self.cancleView removeFromSuperview];
        [self.view removeFromSuperview];
    }];
    
}



#pragma mark -UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"SearchMenuCellID";

    CSearchMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        cell = [[CSearchMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.sectionIndex = indexPath.section;
    
    cell.inputTextField.tag = 1000+indexPath.section;
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]init];
  
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 10, 80, 16)];
    label.backgroundColor=[UIColor whiteColor];
    label.textColor = [UIColor colorWithHex:@"4a4a4a"];
    label.font = [UIFont systemFontOfSize:14.f];
    
    if (section==0) {
        
        label.text =@"姓名";
    }
    else if (section==1) {
        
        label.text = @"手机号";
    }
    else {
        label.text = @"城市";
    }
    
    [headerView addSubview:label];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITextField *textField =  [self.view viewWithTag:_textTag];
    
    UITextField *currentTextField = [self.view viewWithTag:1000+indexPath.section];
    
    
    if (indexPath.section == 2) {
    
        [textField resignFirstResponder];
      
        self.pickerView = [PickerView showAddTo:self.view];
        self.pickerView.picker.delegate = self.protocol;
        self.pickerView.picker.dataSource = self.protocol;
        
        
        [[self.viewModel requestAreaListData:0 lIndex:0]subscribeNext:^(NSMutableArray* x) {
            
            self.protocol.pickerDataArray = x;
            
            self.protocol.pickerDataArrayB =  x[1];
            
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
        
        
        _pickerView.tapConfirmBlock = ^(NSString*parameter) {
            @strongify(self);
      
            UILabel *provinceLabel = [self.view viewWithTag:2000];
            UILabel *cityLabel = [self.view viewWithTag:2001];
            UILabel *townLabel = [self.view viewWithTag:2002];
            provinceLabel.hidden = cityLabel.hidden = townLabel.hidden = NO;
           
            currentTextField.hidden = YES;

            provinceLabel.text = [ self.protocol.pickerDataArray[0]objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
            
            cityLabel.text = [ self.protocol.pickerDataArray[1]objectAtIndex:[self.pickerView.picker selectedRowInComponent:1]];
            
            townLabel.text = [ self.protocol.pickerDataArray[2]objectAtIndex:[self.pickerView.picker selectedRowInComponent:2]];
            
            [self.selectedOptionDic safeSetObject:provinceLabel.text forKey:@"province"];
            [self.selectedOptionDic safeSetObject:cityLabel.text forKey:@"city"];
            [self.selectedOptionDic safeSetObject:townLabel.text forKey:@"county"];
 
        };
        
    }
    
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    UITextField *input = [self.view viewWithTag:textField.tag];
    
    [[input rac_textSignal]subscribeNext:^(NSString * x) {
        
        if (textField.tag == 1000) {
            
            [self.selectedOptionDic safeSetObject:x forKey:@"name"];
        }
        else if (textField.tag == 1001) {
            
            [self.selectedOptionDic safeSetObject:x forKey:@"phone"];
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


#pragma mark - Action
//点击了重置按钮
- (IBAction)resetAction:(UIButton *)sender {
    
    UITextField *textField1 = [self.view viewWithTag:1000];
      UITextField *textField2 = [self.view viewWithTag:1001];
    UITextField *textField3 = [self.view viewWithTag:1002];
    
    textField1.text = textField2.text = nil;
    
    UILabel *provinceLabel = [self.view viewWithTag:2000];
    UILabel *cityLabel = [self.view viewWithTag:2001];
    UILabel *townLabel = [self.view viewWithTag:2002];
    
    provinceLabel.hidden = cityLabel.hidden = townLabel.hidden = YES;
    
    textField3.hidden = NO;

    [self.searchMenuTabelView reloadData];

}
//点击了确定按钮
- (IBAction)confirmAction:(UIButton *)sender {
    
    if (self.tapSearchProductBlock) {
        
        self.tapSearchProductBlock(self.selectedOptionDic);
    }
    
    [UIView animateWithDuration:1 animations:^{
        
        self.bgView.originX = ScreenWidth;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self.cancleView removeFromSuperview];
        [self.view removeFromSuperview];
    }];
}

//点击了选择城市
- (IBAction)SelectCityAction:(UIControl *)sender {
    DDLogDebug(@"点击了选择城市");
}

@end
