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

//@property(nonatomic,strong)   NSMutableArray *array;

@property(nonatomic,strong)ProductManageViewModel *viewModel;

@property(nonatomic,strong)PSearchMenuViewController*searchMenuVC;

@property(nonatomic,strong)NSMutableArray *brandAndPmodelDataArray;//产品名称和型号

@property(nonatomic,strong)NSArray *productRelatedInformationArray;//产品相关信息

@property(nonatomic,strong)NSMutableArray *productInfoDataArray;//产品列表数据数组

@property(nonatomic,strong)NSMutableDictionary *userInfoDic;

@property(nonatomic,strong)AMProductInfo *addProductInfo;
@end

@implementation ProductManageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _userInfoDic = [NSMutableDictionary dictionary];
    
    [self requestData];
    
    [self observeData];

}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (self.addProductInfo != self.productInfo) {
        
        self.addProductInfo = self.productInfo;
        
        if (self.productInfo !=nil) {
            
            [self.productInfoDataArray insertObject:self.productInfo atIndex:0];
            
            self.formTabelView.hidden = NO;
            
            self.formHeaderView.hidden = NO;
            
            [self.formTabelView reloadData];
        }
        
    }
}

#pragma mark - Data
- (void)requestData {
  
    _viewModel = [[ProductManageViewModel alloc]init];

     __weak typeof(self) weakSelf = self;

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

    [RACObserve(self.viewModel, productRelatedInformationArray)subscribeNext:^(NSMutableArray* x) {
        
        weakSelf.productRelatedInformationArray = x;
        
    }];
    
    
    //当前登录用户信息model
    [RACObserve(self, userModel)subscribeNext:^(AMUser* x) {
       
        NSLog(@"%@",x);
        if (x != nil) {
            
            //[weakSelf.userInfoDic setObject:x.user_id forKey:@"u_id"];
//            [weakSelf.userInfoDic setObject:x.add_time forKey:@"add_time"];
//            [weakSelf.userInfoDic setObject:x.an_id forKey:@"an_id"];
            //[weakSelf.userInfoDic setObject:@"ID" forKey:@"id"];
        }
        
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
    
    cell.tapSeeDetailBlock = ^(NSInteger index) {
        
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
        ProductDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ProductDetailID"];
        vc.productInfo = weakSelf.productInfoDataArray[index];
        vc.productRelatedInformationArray = weakSelf.productRelatedInformationArray;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    
    return cell;
}

#pragma mark - Action
- (IBAction)searchMenuAction:(UIButton *)sender {

    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
    _searchMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchMenuViewID"];
    _searchMenuVC.productRelatedInformationArray = self.productRelatedInformationArray;
    [[UIApplication sharedApplication].keyWindow addSubview:_searchMenuVC.view];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier compare:@"AddProductSegueA"]==NO) {
        
        id page2=segue.destinationViewController;
        [page2 setValue:self.productRelatedInformationArray forKey:@"productRelatedInformationArray"];
        [page2 setValue:self.userInfoDic forKey:@"userDic"];
   
    }

}



@end
