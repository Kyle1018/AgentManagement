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
    
    [self requestListData];
    
    [self requestInfoData];
    
    [self observeData];
    
    [self pullRefresh];
    
    [self addOrDeleteProductInfoNotifi];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.formTabelView reloadData];
}

#pragma mark - Data
- (void)requestListData {
  
    WeakObj(self);
    
    //请求产品列表数据
    [[self.viewModel requestProductListDataOrSearchProductDataWithPage:0 Size:0 Search:self.selectedOptionDic] subscribeNext:^(NSNumber* value) {
        
        if ([value integerValue]==3) {
            
            selfWeak.loadingView =[LoadingView showRetryAddToView:self.view];
            selfWeak.formTabelView.hidden = YES;
            selfWeak.loadingView.tapRefreshButtonBlcok = ^() {
                
                //再次请求数据
                [selfWeak requestListData];
            };
        }
        else if ([value integerValue]==2) {
            
            [LoadingView showNoDataAddToView:self.view];
            selfWeak.formTabelView.hidden = YES;
            
        }
        else {
            
            [LoadingView hideLoadingViewRemoveView:self.view];
            selfWeak.formTabelView.hidden = NO;
            [selfWeak.formTabelView reloadData];
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
    
    
////    //品牌和型号数据
//    [RACObserve(self.viewModel, productAndModelArray)subscribeNext:^(NSMutableArray* x) {
//        
//         weakSelf.brandAndPmodelDataArray = x;
//    }];
//    
    //产品相关属性数据
    [RACObserve(self.viewModel, productRelatedInformationArray)subscribeNext:^(NSMutableArray* x) {
        
        weakSelf.productRelatedInformationArray = x;

    }];
}

- (void)pullRefresh {
    
    WeakObj(self);
    
    self.formTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[selfWeak.viewModel requestProductListDataOrSearchProductDataWithPage:0 Size:0 Search:nil]
         
         subscribeNext:^(NSNumber* x) {
             
             if ([x integerValue]==3) {
                 
                 [MBProgressHUD showText:@"数据刷新失败"];
             }
             else {
                 
                 [selfWeak.formTabelView reloadData];
             }
             
             [selfWeak.formTabelView.mj_header endRefreshing];
             
         }];

    }];
    
}

- (void)addOrDeleteProductInfoNotifi {
    
    
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:KDeletaProductInfoNotifi object:nil]subscribeNext:^(NSNotification* notifi){
        
        DDLogDebug(@"获取了删除产品通知");
        
        AMProductInfo *deletProductInfo = notifi.userInfo[@"productInfo"];
        
        NSMutableArray *pInfoArray = [NSMutableArray arrayWithArray:self.productInfoDataArray];
        
        [pInfoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            AMProductInfo *productInfo = obj;
            
            if ([productInfo.pd_id isEqualToString:deletProductInfo.pd_id]) {
                
                [self.productInfoDataArray removeObject:productInfo];
            }
            
        }];
        
    }];
    
    
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:KAddProductInfoNotifi object:nil]subscribeNext:^(NSNotification* notifi){
        
        AMProductInfo *addProductInfo = notifi.userInfo[@"productInfo"];
        
        [self.productInfoDataArray insertObject:addProductInfo atIndex:0];
        [LoadingView hideLoadingViewRemoveView:self.view];
 
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
        
        WeakObj(self);
        
        //进入产品详情
        cell.tapSeeDetailBlock = ^() {
            
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
            ProductDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ProductDetailID"];
            vc.productInfo = selfWeak.productInfoDataArray[indexPath.row-1];
            vc.productRelatedInformationArray = selfWeak.productRelatedInformationArray;
            [selfWeak.navigationController pushViewController:vc animated:YES];
            
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

    [[UIApplication sharedApplication].keyWindow addSubview:_searchMenuVC.view];
    
    
    WeakObj(self);
    //点击了搜索产品回调
    _searchMenuVC.tapSearchProductBlock = ^(NSMutableDictionary*selectedOptionDic) {
        
        selfWeak.selectedOptionDic = [NSMutableDictionary dictionaryWithDictionary:selectedOptionDic];
        
        [selfWeak requestListData];
        
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
