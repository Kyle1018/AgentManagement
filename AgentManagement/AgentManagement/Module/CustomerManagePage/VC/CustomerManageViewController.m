//
//  CustomerManageViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CustomerManageViewController.h"
#import "CustomerDetailViewController.h"
#import "CustomerManageCell.h"
#import "CSearchMenuViewController.h"
#import "CustomerManageViewModel.h"
#import "CustomerDetailViewController.h"
@interface CustomerManageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)CSearchMenuViewController *cSearchMenuVC;

@property(nonatomic,strong)CustomerManageViewModel *viewModel;

@property(nonatomic,strong)NSMutableArray *listDataArray;
@property (weak, nonatomic) IBOutlet UITableView *formTabelView;

@property(nonatomic,strong)LoadingView *loadingView;



@end

@implementation CustomerManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    
    [self observeData];
}

- (void)requestData {
    
    _viewModel = [[CustomerManageViewModel alloc]init];
    
    [[self.viewModel requestCustomerInfoListDataOrSearchCustomerInfoDataWithPage:0 size:0 search:nil]subscribeNext:^(NSNumber* x) {
        
        if ([x integerValue] == 1) {
            
            [LoadingView hideLoadingViewRemoveView:self.view];
            self.formTabelView.hidden = NO;
            [self.formTabelView reloadData];
        }
        else if ([x integerValue] == 2) {
            
            [LoadingView showNoDataAddToView:self.view];
            self.formTabelView.hidden = YES;
        }
        
        else {
            
            self.loadingView =[LoadingView showRetryAddToView:self.view];
            self.formTabelView.hidden = YES;
            
            @weakify(self);
            
            self.loadingView.tapRefreshButtonBlcok = ^() {
                
                @strongify(self);
                
                //再次请求数据
                [self requestData];
            };
        }
    }];
}

- (void)observeData {
    
    [RACObserve(self.viewModel, customerModelArray)subscribeNext:^(NSMutableArray* x) {
       
        NSLog(@"%@",x);
        
        self.listDataArray = x;
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listDataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CustomerManageCellID";
    
    CustomerManageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell= [[CustomerManageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
   
    
    
    if (indexPath.row==0) {
        
        [cell setData:nil];
    }
    else {
        
        [cell setData:self.listDataArray[indexPath.row]];
        
        @weakify(self);
        
        //进入客户管理详情
        cell.tapSeeDetailBlock = ^() {
            
            @strongify(self);
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"CustomerManage" bundle:nil];
            CustomerDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CustomerDetailID"];
            vc.customerModel = self.listDataArray[indexPath.row-1];
            [self.navigationController pushViewController:vc animated:YES];
            
        };
        
    }
    
    
    return cell;
}

- (IBAction)searchMenuAction:(UIButton *)sender {
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"CustomerManage" bundle:nil];
    _cSearchMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"CSearchMenuID"];
    [[UIApplication sharedApplication].keyWindow addSubview:_cSearchMenuVC.view];
}



@end
