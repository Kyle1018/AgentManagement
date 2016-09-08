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

//@property(nonatomic,strong)NSMutableArray *brandAndPmodelDataArray;//产品名称和型号

@property(nonatomic,strong)NSArray *productRelatedInformationArray;//产品相关信息

@property(nonatomic,strong)NSMutableArray *productInfoDataArray;//产品列表数据数组

@property(nonatomic,strong)AMProductInfo *addProductInfo;

@end

@implementation ProductManageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self requestData];
    
    [self observeData];
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

    //请求产品属性信息
    [[[self.viewModel requstProductInformationData]filter:^BOOL(id value) {
       
        if ([value boolValue] == YES) {
            
            return YES;
        }
        else {
            
            return NO;
        }
        
    }]subscribeNext:^(id x) {
       
        //刷新表视图
        [weakSelf.formTabelView reloadData];
    }];
    
    //请求产品列表数据
    [[[self.viewModel requestProductListDataOrSearchProductDataWithPage:0 Size:0 Search:nil]filter:^BOOL(id value) {
        
        if ([value boolValue]==YES) {
            
            return YES;
        }
        else {
            
            return NO;
        }
    }]subscribeNext:^(id x) {
       
        weakSelf.formTabelView.hidden = NO;
        weakSelf.formHeaderView.hidden = NO;
        [weakSelf.formTabelView reloadData];
    }];
}

- (void)observeData {
    
    __weak typeof(self) weakSelf = self;

    //产品相关信息
    [RACObserve(self.viewModel, productRelatedInformationArray)subscribeNext:^(NSMutableArray* x) {
        
        weakSelf.productRelatedInformationArray = x;
        
    }];
    
    //列表数据
    [RACObserve(self.viewModel, productInfoDataArray)subscribeNext:^(NSMutableArray* x) {
       
        weakSelf.productInfoDataArray = x;
    }];
}

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
    
    [cell setData:self.productInfoDataArray[indexPath.row] index:indexPath.row];
  
     __weak typeof(self) weakSelf = self;
    
    //进入产品详情
    cell.tapSeeDetailBlock = ^(NSInteger index) {
        
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
        ProductDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ProductDetailID"];
        vc.productInfo = weakSelf.productInfoDataArray[index];
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

    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
    _searchMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchMenuViewID"];
    _searchMenuVC.productRelatedInformationArray = self.productRelatedInformationArray;
    [[UIApplication sharedApplication].keyWindow addSubview:_searchMenuVC.view];
}

//进入添加产品页面
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier compare:@"AddProductSegueA"]==NO) {
        
        id page2=segue.destinationViewController;
        [page2 setValue:self.productRelatedInformationArray forKey:@"productRelatedInformationArray"];
    }

}

@end
