//
//  AddCustomerViewControllerA.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/14.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddCustomerViewControllerA.h"
#import "UIView+KKFrame.h"

@interface AddCustomerViewControllerA ()<UITextViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *array;
    
    NSMutableArray *arrayA;
    
    NSMutableArray *arrayB;
    
    NSMutableArray *arrayC;
    
    NSInteger _row;
}

@property (weak, nonatomic) IBOutlet UIView *pickerBGView;
@property (weak, nonatomic) IBOutlet UIPickerView *areaPickerView;
@property (strong, nonatomic) UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *townLabel;

@end

@implementation AddCustomerViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];


     [self initView];
    
    [self getPickerData];
}

- (void)initView {
    [self.pickerBGView removeFromSuperview];
    self.maskView = [[UIView alloc] initWithFrame:ScreenFrame];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    self.pickerBGView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 224);
   // self.pickerBGView.width = ScreenWidth;
}

- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBGView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBGView removeFromSuperview];
    }];
}

- (void)getPickerData {
    
    NSString* plistPath=[[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    NSDictionary*dict=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    array = [NSMutableArray arrayWithArray:dict[@"address"]];
    
    arrayA = [NSMutableArray array];
    
    for (NSDictionary*dic in array) {
        
        NSString *name = dic[@"name"];
        
        [arrayA addObject:name];
        
    }
    
    NSDictionary *dicc =array[0];
    
    NSArray *a1=dicc[@"sub"];
    
    arrayB = [NSMutableArray array ];
    
    
    for (NSDictionary*diccc in a1) {
        
        [arrayB addObject:diccc[@"name"]];
        
        arrayC = [NSMutableArray arrayWithArray:diccc[@"sub"]];
    }
}

#pragma pickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return arrayA.count;
    } else if (component == 1) {
        return arrayB.count;
    } else {
        return arrayC.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [arrayA objectAtIndex:row];
    } else if (component == 1) {
        return [arrayB objectAtIndex:row];
    } else {
        return [arrayC objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 42;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    /*
     self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
     self.provinceArray = [self.pickerDic allKeys];
     self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
     
     if (self.selectedArray.count > 0) {
     self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
     }
     
     if (self.cityArray.count > 0) {
     self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
     }
     */
   
    if (component == 0) {
        
        NSDictionary *dicc =array[row];
        
        
        NSArray *a1=dicc[@"sub"];
        
        arrayB = [NSMutableArray array ];
        
        
        for (NSDictionary*diccc in a1) {
            
            [arrayB addObject:diccc[@"name"]];
            
            arrayC = [NSMutableArray arrayWithArray:diccc[@"sub"]];
        }
        
        _row = row;
        NSLog(@"-----%ld",row);
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {

        NSLog(@"%ld",row);
        NSDictionary *dicc =array[_row];
        
        NSArray *a1=dicc[@"sub"];
       
        NSDictionary *dict = a1[row];
      
        arrayC = [NSMutableArray arrayWithArray:dict[@"sub"]];
        
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}


#pragma mark -UITabelViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 4;
}

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
        
        [self.view addSubview:self.maskView];
        [self.view addSubview:self.pickerBGView];
        self.maskView.alpha = 0;
     
        [UIView animateWithDuration:0.3 animations:^{
            self.maskView.alpha = 0.3;
            self.pickerBGView.bottom = ScreenHeight-110;
        }];
    }
    else {
        
        NSLog(@"点击了其它单元格");
    }
}

- (IBAction)confirmPickerView:(id)sender {
    
    self.provinceLabel.text = [arrayA objectAtIndex:[self.areaPickerView selectedRowInComponent:0]];
    
    self.cityLabel.text = [arrayB objectAtIndex:[self.areaPickerView selectedRowInComponent:1]];
    
    self.townLabel.text = [arrayC objectAtIndex:[self.areaPickerView selectedRowInComponent:2]];

    [self hideMyPicker];

}

- (IBAction)canclePickerView:(id)sender {
    
      [self hideMyPicker];
}

- (IBAction)textFieldChanged:(UITextField *)sender {
    
    //客户姓名
    if (sender.tag == 101) {
     
          NSLog(@"客户姓名-------%@",sender.text);
    }
    
    //手机号码
    else if (sender.tag == 102) {
        
          NSLog(@"手机号码-------%@",sender.text);
    }
    
    //TDS值
    else if (sender.tag == 103) {
        
          NSLog(@"TDS值-------%@",sender.text);
    }
    
    //PH值
    else if (sender.tag == 104) {
        
          NSLog(@"PH值-------%@",sender.text);
    }
    
    //硬度
    else if (sender.tag == 105) {
        
          NSLog(@"硬度-------%@",sender.text);
    }
    
    //余氯值
    else if (sender.tag == 106) {
        
          NSLog(@"余氯值-------%@",sender.text);
    }
  
}

@end
