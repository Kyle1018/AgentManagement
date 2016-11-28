//
//  ProductManageViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "ProductManageViewController.h"
#import "ProductManageTableViewCell.h"
#import "PSearchMenuViewController.h"
#import "ProductManageViewModel.h"
#import "ProductDetailViewController.h"

@interface ProductManageViewController ()

@property (weak, nonatomic) IBOutlet UITableView *formTabelView;

@property(nonatomic,strong)ProductManageViewModel *viewModel;

@property(nonatomic,strong)PSearchMenuViewController*searchMenuVC;

@property(nonatomic,strong)NSMutableArray *brandAndPmodelDataArray;//产品名称和型号

@property(nonatomic,strong)NSMutableArray *productRelatedInformationArray;//产品相关信息

@property(nonatomic,strong)NSMutableArray *productInfoDataArray;//产品列表数据数组

@property(nonatomic,strong)NSMutableDictionary*selectedOptionDic;

@property(nonatomic,strong)LoadingView *loadingView;

@end

@implementation ProductManageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _viewModel = [[ProductManageViewModel alloc]init];
    
    [self requestInfoData];
    
    [self observeData];
    
    [self pullRefresh];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self requestListData];

}

#pragma mark - Data
- (void)requestListData {
  
    //请求产品列表数据
    [[self.viewModel requestProductListDataOrSearchProductDataWithPage:0 Size:0 Search:self.selectedOptionDic] subscribeNext:^(NSNumber* value) {
        
        if ([value integerValue]==3) {
            
            self.loadingView =[LoadingView showRetryAddToView:self.view];
            self.formTabelView.hidden = YES;
            
            @weakify(self);
            
            self.loadingView.tapRefreshButtonBlcok = ^() {
                
                @strongify(self);
                
                //再次请求数据
                [self requestListData];
            };
        }
        else if ([value integerValue]==2) {
            
            [LoadingView showNoDataAddToView:self.view];
            self.formTabelView.hidden = YES;
            
        }
        else {
            
            [LoadingView hideLoadingViewRemoveView:self.view];
            self.formTabelView.hidden = NO;
            [self.formTabelView reloadData];
        }
    }];
        
}

- (void)requestInfoData {
    
//    //请求产品品牌和型号数据
//    [[self.viewModel requestProductBrandAndPmodelData]subscribeNext:^(NSNumber* x) {
//        
//        if ([x boolValue]==NO) {
//            
//            //请求数据失败
//        }
//        
//        
//    }];
//
    
    [[self.viewModel requestProductBrandAndPmodelData]subscribeNext:^(id x) {
        
    }];
    
    //请求产品属性信息
    [[self.viewModel requstProductInformationData]subscribeNext:^(id x) {
        
        if ([x isKindOfClass:[NSMutableArray class]]) {
            
               self.productRelatedInformationArray = x;
        }
        
    }];
}

- (void)observeData {
    
    //列表数据
    [RACObserve(self.viewModel, productInfoDataArray)subscribeNext:^(NSMutableArray* x) {
       
        self.productInfoDataArray = x;
    }];
    
}

- (void)pullRefresh {
    
    @weakify(self);
    
    self.formTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        [[self.viewModel requestProductListDataOrSearchProductDataWithPage:0 Size:0 Search:nil]
         
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

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.productInfoDataArray.count>0) {
        
        return self.productInfoDataArray.count+1;
    }
    else {
        
        return 0;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"ProductManageCellId";
    
    ProductManageTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
    if (!cell) {
            
        cell =[[ProductManageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.row==0) {
        
        cell.model = nil;
    }
    else {
        
        cell.model = self.productInfoDataArray[indexPath.row-1];
        
        @weakify(self);
        
        //进入产品详情
        cell.tapSeeDetailBlock = ^() {
            @strongify(self);
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
            ProductDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ProductDetailID"];
            vc.productInfo = self.productInfoDataArray[indexPath.row-1];
            vc.productRelatedInformationArray = self.productRelatedInformationArray;
            [self.navigationController pushViewController:vc animated:YES];
            
        };
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]init];
    
    headerView.backgroundColor=[UIColor clearColor];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,19, self.formTabelView.width, 1)];
    
    lineView.backgroundColor=self.productInfoDataArray.count>0?[UIColor colorWithHex:@"b8b8b8"]:[UIColor clearColor];
    
    [headerView addSubview:lineView];
    
    return headerView;
}

#pragma mark - Action
//进入搜索产品页面
- (IBAction)searchMenuAction:(UIButton *)sender {
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
    
    _searchMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchMenuViewID"];
    
    _searchMenuVC.productRelatedInformationArray = self.productRelatedInformationArray;

    [kAppWindow addSubview:_searchMenuVC.view];
    
    @weakify(self);
    //点击了搜索产品回调
    _searchMenuVC.tapSearchProductBlock = ^(NSMutableDictionary*selectedOptionDic) {
        
        @strongify(self);
        
        self.selectedOptionDic = [NSMutableDictionary dictionaryWithDictionary:selectedOptionDic];
        
        [self requestListData];
        
    };
}

//进入添加产品页面
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier compare:@"AddProductSegueA"]==NO) {
        
        id page2=segue.destinationViewController;

        [page2 setValue:self.productRelatedInformationArray forKey:@"productRelatedInformationArray"];
    }

}

@end
