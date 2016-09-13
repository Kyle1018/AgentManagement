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

@property (weak, nonatomic) IBOutlet UIView *formHeaderView;

@property(nonatomic,strong)ProductManageViewModel *viewModel;

@property(nonatomic,strong)PSearchMenuViewController*searchMenuVC;

@property(nonatomic,strong)NSMutableArray *brandAndPmodelDataArray;//产品名称和型号

@property(nonatomic,strong)NSArray *productRelatedInformationArray;//产品相关信息

@property(nonatomic,strong)NSMutableArray *productInfoDataArray;//产品列表数据数组

@property(nonatomic,strong)AMProductInfo *addProductInfo;

@end

@implementation ProductManageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self requestData];
    
   // [self observeData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //获取添加后的数据模型
    if (self.addProductInfo != self.productInfo && self.productInfo !=nil) {
        
        self.addProductInfo = self.productInfo;
        
        [self.productInfoDataArray insertObject:self.productInfo atIndex:0];
            
        self.formTabelView.hidden = NO;
            
        self.formHeaderView.hidden = NO;
            
        [self.formTabelView reloadData];

    }
}

#pragma mark - Data
- (void)requestData {
  
    _viewModel = [[ProductManageViewModel alloc]init];

     __weak typeof(self) weakSelf = self;

    //请求产品品牌和型号数据
    [[self.viewModel requestProductBrandAndPmodelData]subscribeNext:^(NSMutableArray* x) {
        
        weakSelf.brandAndPmodelDataArray = x;
    }];
    
    //请求产品属性信息
    [[self.viewModel requstProductInformationData]subscribeNext:^(id x) {
       
        weakSelf.productRelatedInformationArray = x;

    }];
    
    //请求产品列表数据
    [[self.viewModel requestProductListDataOrSearchProductDataWithPage:0 Size:0 Search:nil]subscribeNext:^(NSMutableArray* x) {
       
        weakSelf.productInfoDataArray = x;
        
        weakSelf.formTabelView.hidden = NO;
        weakSelf.formHeaderView.hidden = NO;
        [weakSelf.formTabelView reloadData];
    }];
}
//
//- (void)observeData {
//    
//    __weak typeof(self) weakSelf = self;
//    
//    //列表数据
//    [RACObserve(self.viewModel, productInfoDataArray)subscribeNext:^(NSMutableArray* x) {
//       
//        weakSelf.productInfoDataArray = x;
//    }];
//    
//}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.productInfoDataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"ProductManageCellId";
        
    ProductManageTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
    if (!cell) {
            
        cell =[[ProductManageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.model = self.productInfoDataArray[indexPath.row];
  
     __weak typeof(self) weakSelf = self;
    
    //进入产品详情
    cell.tapSeeDetailBlock = ^(NSInteger index) {
        
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
        ProductDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ProductDetailID"];
        vc.productInfo = weakSelf.productInfoDataArray[indexPath.row];
        vc.productRelatedInformationArray = weakSelf.productRelatedInformationArray;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
        //产品详情页点击了删除产品信息回调
        vc.tapDeleteProductBlock = ^() {
            
            [weakSelf.productInfoDataArray removeObjectAtIndex:index];
            
            if (weakSelf.productInfoDataArray.count > 0) {
                
                 [weakSelf.formTabelView reloadData];
            }
            else {
                
                weakSelf.formHeaderView.hidden = YES;
                weakSelf.formTabelView.hidden = YES;
            }
            
        };
        
    };
    
    return cell;
}

#pragma mark - Action
//进入搜索产品页面
- (IBAction)searchMenuAction:(UIButton *)sender {

    __weak typeof(self) weakSelf = self;
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
    
    _searchMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchMenuViewID"];
    
    NSMutableArray *array = self.productRelatedInformationArray[1];
    
    [array insertObject:[self.brandAndPmodelDataArray firstObject] atIndex:0];
    
    [array insertObject:self.brandAndPmodelDataArray[1] atIndex:1];
    
    _searchMenuVC.productRelatedInformationArray = self.productRelatedInformationArray;

    [[UIApplication sharedApplication].keyWindow addSubview:_searchMenuVC.view];
    
    
    //点击了搜索产品回调
    
    _searchMenuVC.tapSearchProductBlock = ^(NSMutableArray*searchResutList) {
        
        if (searchResutList.count > 0) {
            
            [weakSelf.productInfoDataArray removeAllObjects];
            
            [weakSelf.productInfoDataArray addObjectsFromArray:searchResutList];
            
            weakSelf.formHeaderView.hidden = NO;
            weakSelf.formTabelView.hidden = NO;
            
            [weakSelf.formTabelView reloadData];
            
        }
    
        else {
            
            weakSelf.formHeaderView.hidden = YES;
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
