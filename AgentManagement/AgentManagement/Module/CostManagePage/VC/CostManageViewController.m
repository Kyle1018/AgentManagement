//
//  CostManageViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CostManageViewController.h"
#import "CostManageTableViewCell.h"
#import "CoSearchMenuViewController.h"
#import "ProductManageViewModel.h"
#import "CostManagerListHeaderView.h"
#import "CostManageDetailViewController.h"

@interface CostManageViewController ()

@property(nonatomic,strong)CoSearchMenuViewController *coSearchMenuVC;
@property(nonatomic,strong)ProductManageViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *formTabelView;
@property(nonatomic,strong)NSMutableDictionary *listDataDic;
@property(nonatomic,strong)NSMutableArray *keysArray;
@property(nonatomic,copy)NSString* lastDate;
//@property(nonatomic,strong)NSMutableArray *isHaveData;
@property(nonatomic,strong)LoadingView *loadingView;
@end

@implementation CostManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initProperty];
    
    [self requestData];
    
    [self observeData];
    
    [self pullRefresh];
    
    [self notifi];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.formTabelView reloadData];
}

- (void)initProperty {
    
    _listDataDic = [NSMutableDictionary dictionary];
    
   // _isHaveData = [NSMutableArray array];
    
    _viewModel = [[ProductManageViewModel alloc]init];
    
    _keysArray = [NSMutableArray array];
}

- (void)observeData {
    
   WeakObj(self)
    //列表数据
    [RACObserve(self.viewModel, productInfoDataArray)subscribeNext:^(NSMutableArray* x) {
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (AMProductInfo *productInfo in x) {
            
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM"];
            
            NSString *currentDateStr = [NSString timeTransformString:productInfo.add_time dateFormatter:dateFormatter];
            
            if ([currentDateStr isEqualToString:selfWeak.lastDate]) {
                
                [dataArray addObject:productInfo];
                
                [selfWeak.listDataDic safeSetObject:dataArray forKey:currentDateStr];
            }
            else {
                
                NSMutableArray *dd = [NSMutableArray array];
                
                [dd addObject:productInfo];
                
                [selfWeak.listDataDic safeSetObject:dd forKey:currentDateStr];
                
               //dataArray =dd;
            }
            
            selfWeak.lastDate = currentDateStr;
            
        }
     
        [selfWeak.keysArray addObjectsFromArray:[selfWeak.listDataDic allKeys]];
     
    }];
}

- (void)requestData {
    
    WeakObj(self);

    [LoadingView showLoadingAddToView:self.view];
    
    //“成本管理列表”调用“产品管理列表”中的数据进行显示。
    [[[self.viewModel requestProductListDataOrSearchProductDataWithPage:0 Size:0 Search:nil]delay:0.5]

      subscribeNext:^(NSNumber* x) {
          
          if ([x integerValue]==3) {
              
              selfWeak.loadingView =[LoadingView showRetryAddToView:self.view];
              selfWeak.formTabelView.hidden = YES;
              selfWeak.loadingView.tapRefreshButtonBlcok = ^() {
                  
                  //再次请求数据
                  [selfWeak requestData];
              };

          }
          else {
              
              [LoadingView hideLoadingViewRemoveView:self.view];
              selfWeak.formTabelView.hidden = NO;
              [selfWeak.formTabelView reloadData];
          }
    }];
}

- (void)pullRefresh {
    
     WeakObj(self);
    
    self.formTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
//        [[NSNotificationCenter defaultCenter]postNotificationName:KProductListOrCostListPullRefreshNotifi object:nil];
        [selfWeak.listDataDic removeAllObjects];
        [selfWeak.keysArray removeAllObjects];
        
        [selfWeak pullRefreshRequestListData];
        
    }];
    
}

- (void)notifi {
    

    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:KDeletaProductInfoNotifi object:nil]subscribeNext:^(NSNotification* notifi) {
        
        NSLog(@"%@",notifi.userInfo);
        AMProductInfo *deleteProductInfo=notifi.userInfo[@"productInfo"];
        
        for (NSString *key in self.keysArray) {
            
            NSMutableArray *array = [NSMutableArray arrayWithObject:[self.listDataDic objectForKey:key]];
            
            
            
            for (NSMutableArray *productArray in array) {
                
                NSMutableArray *array = [NSMutableArray arrayWithArray:productArray];
                
                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   
                    AMProductInfo *productInfo = obj;
                    
                    if ([productInfo.pd_id isEqualToString:deleteProductInfo.pd_id]) {
                        
                        [productArray removeObject:productInfo];
                    }
                }];
                
//                for (AMProductInfo *productInfo in productArray) {
//                    
//                    if ([productInfo.pd_id isEqualToString:deleteProductInfo.pd_id]) {
//                        
//                        [productArray removeObject:productInfo];
//                    }
//                }
//                
                
//                if (productArray.count>0) {
//                    
//                    [_isHaveData addObject:@(YES)];
//                }
//                else {
//                    
//                    [self.listDataDic removeObjectForKey:key];
//                    
//                    [_isHaveData addObject:@(NO)];
//                }
            }
            
        }
        
    }];
    

    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:KAddProductInfoNotifi object:nil]subscribeNext:^(NSNotification* notifi){
        
        AMProductInfo *addProductInfo = notifi.userInfo[@"productInfo"];
        
        //如果列表没有数据时——
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //    //设定时间格式,这里可以设置成自己需要的格式
        //[dateFormatter setDateFormat:@"yyyy/MM/dd"];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSString *currentDateStr =[NSString timeTransformString:addProductInfo.add_time dateFormatter:dateFormatter];
        
        if (self.keysArray.count == 0) {
            
            NSMutableArray *dd = [NSMutableArray array];
            
            [dd addObject:addProductInfo];
            
            [self.listDataDic safeSetObject:dd forKey:currentDateStr];
 
        }
        //如果列表已经有数据了
        else {
            
            for (NSString *key in self.keysArray) {
                
                if ([key isEqualToString:currentDateStr]) {
                    
                    NSMutableArray *array=[self.listDataDic objectForKey:key];
                    
                    [array insertObject:addProductInfo atIndex:0];
                }
                else {
                    
                    NSMutableArray *dd = [NSMutableArray array];
                    
                    [dd addObject:addProductInfo];
                    
                    [self.listDataDic safeSetObject:dd forKey:currentDateStr];
                }
            }
        }
        
        [self.keysArray removeAllObjects];
        [self.keysArray addObjectsFromArray:[self.listDataDic allKeys]];
        
    }];
    
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:KProductListOrCostListPullRefreshNotifi object:nil]subscribeNext:^(id x) {
       
        [self pullRefreshRequestListData];
        
    }];
}

- (void)pullRefreshRequestListData {
    
    WeakObj(self);
    
    [[[self.viewModel requestProductListDataOrSearchProductDataWithPage:0 Size:0 Search:nil]delay:1]
     
     subscribeNext:^(NSNumber* x) {
         
         if ([x integerValue] == 3) {
             
             [MBProgressHUD showText:@"数据刷新失败"];
             
         }
         else {
             
             [selfWeak.formTabelView reloadData];
         }
         
         [selfWeak.formTabelView.mj_header endRefreshing];
     }];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.listDataDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *key = self.keysArray[section];
    
    if ([[self.listDataDic objectForKey:key] count]>0) {
        
        return [[self.listDataDic objectForKey:key] count]+1;
        
    }
    else {
        
        return 0;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CostManageCellID";
    
    CostManageTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell =[[CostManageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.row == 0) {
        
        cell.productInfo = nil;
        
    }
    
    else {
        
        NSString *key = self.keysArray[indexPath.section];
        
        cell.productInfo = [[self.listDataDic objectForKey:key]objectAtIndex:indexPath.row-1];
        
        __weak typeof(self) weakSelf = self;

        cell.tapSeeDetailBlock = ^() {
            
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"CostManage" bundle:nil];
            CostManageDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CostManageDetailID"];
            vc.productInfo = [[self.listDataDic objectForKey:key]objectAtIndex:indexPath.row-1];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        };
    }
    
    return cell;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CostManagerListHeaderView *headerView =[[[NSBundle mainBundle]loadNibNamed:@"CostManagerListHeaderView" owner:nil options:nil]lastObject];
    
    
    NSString *key = self.keysArray[section];
    
    if ([[self.listDataDic objectForKey:key] count]>0) {
        
         headerView.hidden = NO;
        
    }
    else {
        
        headerView.hidden = YES;
    }
    
    headerView.date = self.keysArray[section];

    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    return 40;
}

#pragma mark - Action
- (IBAction)searchMenuAction:(UIButton *)sender {
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"CostManage" bundle:nil];
    _coSearchMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"CoSearchMenuViewID"];
    [[UIApplication sharedApplication].keyWindow addSubview:_coSearchMenuVC.view];
}

@end
