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

@interface ProductManageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *formTabelView;

@property(nonatomic,strong)ProductManageViewModel *viewModel;

@property(nonatomic,strong)PSearchMenuViewController*searchMenuVC;

@property(nonatomic,strong)NSMutableArray *brandAndPmodelDataArray;//产品名称和型号

@property(nonatomic,strong)NSArray *productRelatedInformationArray;//产品相关信息

@property(nonatomic,strong)NSMutableArray *productInfoDataArray;//产品列表数据数组

@property(nonatomic,strong)AMProductInfo *addProductInfo;

@property(nonatomic,strong)LoadingView *loadingView;
@end

@implementation ProductManageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _viewModel = [[ProductManageViewModel alloc]init];
    
    [self requestListData];
    
    [self requestInfoData];
    
    [self observeData];
    
    [self pullRefresh];
    
    
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:KDeletaProductInfoNofi object:nil]subscribeNext:^(NSNotification* notifi){
       
        NSLog(@"获取了删除产品通知");
        
        AMProductInfo *deletProductInfo = notifi.userInfo[@"productInfo"];
        
        for (AMProductInfo *productInfo in self.productInfoDataArray) {
            
            if ([productInfo.pd_id isEqualToString:deletProductInfo.pd_id]) {
                
                [self.productInfoDataArray removeObject:productInfo];
            }
        }
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.formTabelView reloadData];
    
    //获取添加后的数据模型
    if (self.addProductInfo != self.productInfo && self.productInfo !=nil) {
        
        self.addProductInfo = self.productInfo;
        
        [self.productInfoDataArray insertObject:self.productInfo atIndex:0];
            
        self.formTabelView.hidden = NO;
        
        [self.formTabelView reloadData];

    }

}

#pragma mark - Data
- (void)requestListData {
  
    WeakObj(self);
    
    [LoadingView showLoadingAddToView:self.view];

    //请求产品列表数据
    [[[self.viewModel requestProductListDataOrSearchProductDataWithPage:0 Size:0 Search:nil]delay:0.5]subscribeNext:^(NSNumber* value) {
        
        if ([value integerValue]==1) {
            
            [LoadingView hideLoadingViewRemoveView:self.view];
            [selfWeak.formTabelView reloadData];
        }
        else if ([value integerValue] == 2) {
            
            [LoadingView showNoDataAddToView:self.view];
            selfWeak.formTabelView.hidden = YES;
        }
        else {
            
            selfWeak.loadingView =[LoadingView showRetryAddToView:self.view];
            
            selfWeak.loadingView.tapRefreshButtonBlcok = ^() {
                
                //再次请求数据
                [selfWeak requestListData];
            };
        }
    }];
        
}

- (void)requestInfoData {
    
    //请求产品品牌和型号数据
    [[self.viewModel requestProductBrandAndPmodelData]subscribeNext:^(NSNumber* x) {
        
        if ([x boolValue]==NO) {
            
            //请求数据失败
        }
        
        
    }];
    
    //请求产品属性信息
    [[self.viewModel requstProductInformationData]subscribeNext:^(NSNumber* x) {
        
        if ([x boolValue]==NO) {
            
            //请求数据失败
        }
        
    }];
}

- (void)observeData {
    
    __weak typeof(self) weakSelf = self;
    
    //列表数据
    [RACObserve(self.viewModel, productInfoDataArray)subscribeNext:^(NSMutableArray* x) {
       
        weakSelf.productInfoDataArray = x;
    }];
    
    
    [RACObserve(self.viewModel, productAndModelArray)subscribeNext:^(NSMutableArray* x) {
        
         weakSelf.brandAndPmodelDataArray = x;
    }];
    
    
    [RACObserve(self.viewModel, productRelatedInformationArray)subscribeNext:^(NSMutableArray* x) {
        
        weakSelf.productRelatedInformationArray = x;

    }];
}

- (void)pullRefresh {
    
    WeakObj(self);
    
    self.formTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[selfWeak.viewModel requestProductListDataOrSearchProductDataWithPage:0 Size:0 Search:nil]
         
         subscribeNext:^(NSNumber* x) {
             
             if ([x integerValue] == 1) {
                 
                 [selfWeak.formTabelView reloadData];
             }
             else {
                 
                 [MBProgressHUD showText:@"数据刷新失败"];
             }
             
             [selfWeak.formTabelView.mj_header endRefreshing];
   
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
        
        
    }
    else {
        
        cell.model = self.productInfoDataArray[indexPath.row-1];
        
        __weak typeof(self) weakSelf = self;
        
        //进入产品详情
        cell.tapSeeDetailBlock = ^() {
            
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
            ProductDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ProductDetailID"];
            vc.productInfo = weakSelf.productInfoDataArray[indexPath.row];
            vc.productRelatedInformationArray = weakSelf.productRelatedInformationArray;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
            //产品详情页点击了删除产品信息回调
            //        vc.tapDeleteProductBlock = ^() {
            //
            //            [weakSelf.productInfoDataArray removeObjectAtIndex:indexPath.row];
            //
            //            if (weakSelf.productInfoDataArray.count > 0) {
            //
            //                 [weakSelf.formTabelView reloadData];
            //            }
            //            else {
            //
            //                weakSelf.formHeaderView.hidden = YES;
            //                weakSelf.formTabelView.hidden = YES;
            //            }
            //
            //        };
            
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

    __weak typeof(self) weakSelf = self;
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
    
    _searchMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchMenuViewID"];
    
    NSMutableArray *productRelatedInformationArray = self.productRelatedInformationArray[1];
    
    [productRelatedInformationArray insertObject:[self.brandAndPmodelDataArray firstObject] atIndex:0];
    
    [productRelatedInformationArray insertObject:self.brandAndPmodelDataArray[1] atIndex:1];
    
    _searchMenuVC.productRelatedInformationArray = self.productRelatedInformationArray;

    [[UIApplication sharedApplication].keyWindow addSubview:_searchMenuVC.view];
    
    
    //点击了搜索产品回调
    
    _searchMenuVC.tapSearchProductBlock = ^(NSMutableArray*searchResutList) {
        
        if (searchResutList.count > 0) {
            
            [weakSelf.productInfoDataArray removeAllObjects];
            
            [weakSelf.productInfoDataArray addObjectsFromArray:searchResutList];
            
            weakSelf.formTabelView.hidden = NO;
            
            [weakSelf.formTabelView reloadData];
            
        }
    
        else {
            
            weakSelf.formTabelView.hidden = YES;
            [weakSelf.formTabelView reloadData];
        }
        
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
