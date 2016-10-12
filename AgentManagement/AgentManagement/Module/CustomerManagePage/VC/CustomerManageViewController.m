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

@property(nonatomic,strong)AMCustomer *customer;

@property(nonatomic,strong)NSMutableDictionary*selectedOptionDic;

@end

@implementation CustomerManageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
     _viewModel = [[CustomerManageViewModel alloc]init];
    
    [self observeData];
    
    [self pullRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
 
    [self requestData];
    
}

- (void)requestData {
    
    [[self.viewModel requestCustomerInfoListDataOrSearchCustomerInfoDataWithPage:0 size:0 search:self.selectedOptionDic]subscribeNext:^(NSNumber* x) {
        
        if ([x integerValue] == 1) {
            
            [LoadingView hideLoadingViewRemoveView:self.view];
            self.formTabelView.hidden = NO;
            [self.formTabelView reloadData];
        }
        else if ([x integerValue] == 2) {
 
            self.formTabelView.hidden = YES;
            [LoadingView showNoDataAddToView:self.view];
           
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

- (void)pullRefresh {
    
    self.formTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[self.viewModel requestCustomerInfoListDataOrSearchCustomerInfoDataWithPage:0 size:0 search:nil]
         
         subscribeNext:^(NSNumber* x) {
             
             if ([x integerValue]==3) {
                 
                 [MBProgressHUD showText:@"数据刷新失败"];
             }
             else {
                 
                 [self.formTabelView reloadData];
             }
             
             [self.formTabelView.mj_header endRefreshing];
             
         }];
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listDataArray.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
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
        
        [cell setData:self.listDataArray[indexPath.row-1]];
        
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
    
    @weakify(self);
    //点击了搜索产品回调
    _cSearchMenuVC.tapSearchProductBlock = ^(NSMutableDictionary*selectedOptionDic) {
        
        @strongify(self);
        
        self.selectedOptionDic = [NSMutableDictionary dictionaryWithDictionary:selectedOptionDic];
        
        [self requestData];
        
    };
}

@end
