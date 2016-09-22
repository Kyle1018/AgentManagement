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
#import "PickerView.h"
@interface CSearchMenuViewController()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *bgView;//背景视图

@property (strong, nonatomic) IBOutlet UIView *cancleView;//取消视图

@property(nonatomic,strong)CustomerManageViewModel *viewModel;

@property(nonatomic,strong)NSMutableDictionary *areaDic;

@property(nonatomic,assign)NSInteger lRow;

@property(nonatomic,assign)NSInteger textTag;

@property(nonatomic,strong)PickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITableView *searchMenuTabelView;

@property(nonatomic,strong)NSMutableDictionary *selectedOptionDic;

@end

@implementation CSearchMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.bgView.originX = ScreenWidth;
    
    [self.cancleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenuView)]];
    
    [self requestData];
    
    _selectedOptionDic = [NSMutableDictionary dictionary];
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

- (void)requestData {
    
    _viewModel = [[CustomerManageViewModel alloc]init];
    
    [[self.viewModel requestAreaListData:0 lIndex:0]subscribeNext:^(NSDictionary* x) {
        
        self.areaDic = [NSMutableDictionary dictionaryWithDictionary:x];
        
    }];
    
}


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
    
    UILabel *provinceLabel = [self.view viewWithTag:2000];
    UILabel *cityLabel = [self.view viewWithTag:2001];
    UILabel *townLabel = [self.view viewWithTag:2002];
    
    if (indexPath.section == 2) {
    
        [textField resignFirstResponder];
      
        _pickerView = [PickerView showAddTo:self.view];
        _pickerView.picker.delegate = self;
        _pickerView.picker.dataSource = self;
        
           @weakify(self);
        _pickerView.tapConfirmBlock = ^(NSString*parameter) {
            @strongify(self);
      
            provinceLabel.hidden = cityLabel.hidden = townLabel.hidden = NO;
           
            currentTextField.hidden = YES;
            
            provinceLabel.text = [self.areaDic[@"province"]objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
            
            cityLabel.text = [self.areaDic[@"city"]objectAtIndex:[self.pickerView.picker selectedRowInComponent:1]];
            
            townLabel.text = [self.areaDic[@"district"]objectAtIndex:[self.pickerView.picker selectedRowInComponent:2]];
            
            
            [self.selectedOptionDic safeSetObject: provinceLabel.text forKey:@"province"];
            [self.selectedOptionDic safeSetObject: cityLabel.text forKey:@"city"];
            [self.selectedOptionDic safeSetObject: townLabel.text forKey:@"county"];
            
//            [weakSelf.addCutomerInfoDic safeSetObject:provinceLabel.text forKey:@"province"];
//            [weakSelf.addCutomerInfoDic safeSetObject:cityLabel.text forKey:@"city"];
//            [weakSelf.addCutomerInfoDic safeSetObject:townLabel.text forKey:@"county"];
            
        };
        
    }
    
//    else {
//        
//        provinceLabel.hidden = cityLabel.hidden = townLabel.hidden = YES;
//        te
//        
//    }
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
