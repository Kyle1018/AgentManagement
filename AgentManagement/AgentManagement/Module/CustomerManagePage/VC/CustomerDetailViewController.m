//
//  CustomerDetailViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/18.
//  Copyright © 2016年 KK. All rights reserved.

#import "CustomerDetailViewController.h"
#import "AlertController.h"
#import "CustomerDetailCell.h"
#import "CustomerManageViewModel.h"

@interface CustomerDetailViewController ()

@property(nonatomic,strong)AlertController *alertVC;

@property(nonatomic,strong)UIView *maskView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,assign)BOOL isTapEditing;

@property(nonatomic,strong)CustomerManageViewModel *viewModel;

//@property(nonatomic,strong)NSMutableSet *indexPathSet;

@end

@implementation CustomerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@",self.customerModel);
    // [self createMaskView];
    
    //_indexPathSet = [NSMutableSet set];
    
    _titleArray = @[@[@"客户姓名:",@"手机号:",@"客户地址:"],@[@"TDS值",@"PH值",@"硬度",@"余氯值"],@[@"购买品牌:",@"购买时间:",@"安装时间:",@"换芯周期:"],@[@"管理员:",@"管理员手机号:"]];
    
    _viewModel = [[CustomerManageViewModel alloc]init];
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        return 80;
    }
    else {
        
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
   
    return  4+self.customerModel.orderArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {//第一组
        
        return 3;
    }
    
    else if (section == 1) {//第二组
        
        return 4;
    }
    
    else if (section == 4+self.customerModel.orderArray.count-1) {
        
        return 1;
    }
    else if (section == 4+self.customerModel.orderArray.count-2) {
        
        return 2;
    }
    
    else {
        
        return 4;
    }

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cutomerDetialCellID";
    
    CustomerDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        cell= [[CustomerDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }

    [cell setDataWithTitle:_titleArray customer:self.customerModel indexPaht:indexPath];
  
    cell.textView.editable = cell.textField.enabled = self.tableView.allowsSelection = self.isTapEditing==YES?YES:NO;
    
    return cell;
   
}


#pragma mark - Action
//编辑菜单
- (IBAction)editCutomerAction:(UIButton *)sender {
    
    
    self.alertVC = [AlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    self.alertVC.actionButtonArray = @[@"编辑客户",@"删除客户"];
  
    @weakify(self);
    self.alertVC.tapActionButtonBlock = ^(NSInteger alertTag,NSString* keyName,NSInteger index) {
        
        @strongify(self);
        if (index == 0) {
            
            DDLogDebug(@"点击了编辑客户");

            self.isTapEditing = YES;
            
            [self.tableView reloadData];
            
            
            
        }
        else {
            
            DDLogDebug(@"点击删除客户");
            self.alertVC = [AlertController alertControllerWithTitle:@"确认删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
            self.alertVC.alertOptionName = @[@"确定",@"取消"];
            [self presentViewController: self.alertVC animated: YES completion:nil];
            
            @weakify(self);
            //点击了确定删除
            self.alertVC.tapExitButtonBlock = ^() {
                @strongify(self);
                
                //删除请求
                
                NSInteger customer_id = self.customerModel.cutomer_id;
                
               [[self.viewModel requestDeleteCustomer:customer_id]subscribeNext:^(id x) {
                   
                   if (self.tapDeleteCustomerBlock) {

                       self.tapDeleteCustomerBlock(customer_id);
                   }

                  [self.navigationController popViewControllerAnimated:YES];
                   
               }];
                
                
               
            };
            
        }
    };
    
    [self presentViewController: self.alertVC animated: YES completion:^{
        
        
    }];
}

#pragma mark - UITextFieldDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    
//    [self.view addSubview:self.maskView];
//    self.maskView.alpha = 0;
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.maskView.alpha = 0.3;
//    }];
//    
//    return YES;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    

    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark -UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
//    UITextView *input = [self.view viewWithTag:textView.tag];
//    __weak typeof(self) weakSelf = self;
//    
//    [[input rac_textSignal]subscribeNext:^(id x) {
//        
//       // [weakSelf.addCutomerInfoDic safeSetObject:x forKey:@"address"];
//        
//        //_textTag = textView.tag;
//    }];
//    
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

@end
