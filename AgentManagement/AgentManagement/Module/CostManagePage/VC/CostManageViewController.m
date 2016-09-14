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
@property(nonatomic,strong)NSMutableArray *isHaveData;
@property(nonatomic,strong)LoadingView *loadingView;
@end

@implementation CostManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initProperty];
    
    [self requestData];
    
    [self observeData];
    
    [self pullRefresh];
    
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:KDeletaProductInfoNofi object:nil]subscribeNext:^(NSNotification* notifi) {
        
        NSLog(@"%@",notifi.userInfo);
         AMProductInfo *deleteProductInfo=notifi.userInfo[@"productInfo"];
        
        for (NSString *key in self.keysArray) {
            
            NSMutableArray *array = [NSMutableArray arrayWithObject:[self.listDataDic objectForKey:key]];
            
            
            for (NSMutableArray *productArray in array) {
                
                for (AMProductInfo *productInfo in productArray) {
                    
                    if ([productInfo.pd_id isEqualToString:deleteProductInfo.pd_id]) {
                        
                        [productArray removeObject:productInfo];
                    }
                }
                
                
                if (productArray.count>0) {
                    
                    [_isHaveData addObject:@(YES)];
                }
                else {
                    
                    [self.listDataDic removeObjectForKey:key];
                  
                    [_isHaveData addObject:@(NO)];
                }
            }

        }
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (self.isHaveData.count>0) {
        
        if ([self.isHaveData containsObject:@(YES)]) {
            
            [self.formTabelView reloadData];
        }
        else {
            
             [self.formTabelView reloadData];
           // self.formTabelView.hidden = YES;
        }
    }
}

- (void)initProperty {
    
    _listDataDic = [NSMutableDictionary dictionary];
    
    _isHaveData = [NSMutableArray array];
    
    _viewModel = [[ProductManageViewModel alloc]init];
    
    _keysArray = [NSMutableArray array];
}

- (void)observeData {
    
    __weak typeof(self) weakSelf = self;
    //列表数据
    [RACObserve(self.viewModel, productInfoDataArray)subscribeNext:^(NSMutableArray* x) {
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (AMProductInfo *productInfo in x) {
            
            NSTimeInterval time=[productInfo.add_time doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
            NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
            NSLog(@"date:%@",[detaildate description]);
            //实例化一个NSDateFormatter对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设定时间格式,这里可以设置成自己需要的格式
            //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            [dateFormatter setDateFormat:@"yyyy-MM"];
            NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
            
            NSLog(@"日期时间%@",currentDateStr);
            
            if ([currentDateStr isEqualToString:weakSelf.lastDate]) {
                
                [dataArray addObject:productInfo];
                
                [weakSelf.listDataDic safeSetObject:dataArray forKey:currentDateStr];
            }
            else {
                
                NSMutableArray *dd = [NSMutableArray array];
                
                [dd addObject:productInfo];
                
                [weakSelf.listDataDic safeSetObject:dd forKey:currentDateStr];
                
                dataArray =dd;
            }
            
            weakSelf.lastDate = currentDateStr;
            
        }
        
        [weakSelf.keysArray addObjectsFromArray:[weakSelf.listDataDic allKeys]];
     
    }];
}

- (void)requestData {
    
    WeakObj(self);

    [LoadingView ShowLoadingAddToView:self.view];
    
    //“成本管理列表”调用“产品管理列表”中的数据进行显示。
    [[[self.viewModel requestProductListDataOrSearchProductDataWithPage:0 Size:0 Search:nil]delay:1]

      subscribeNext:^(NSNumber* x) {
          
          if ( [x integerValue]==1) {
              
              [LoadingView hideLoadingViewRemoveView:self.view];
              [selfWeak.formTabelView reloadData];
          }
          else if ( [x integerValue]==2) {
              
            [LoadingView hideLoadingViewRemoveView:self.view];
              selfWeak.formTabelView.hidden = YES;
          }
          
          else {

             selfWeak.loadingView =[LoadingView ShowRetryAddToView:self.view];
            
              selfWeak.loadingView.tapRefreshButtonBlcok = ^() {
  
                  //再次请求数据
                  [selfWeak requestData];
              };
              
              //请求数据失败，
          }
    }];
}

- (void)pullRefresh {
    
     WeakObj(self);
    
    self.formTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[[selfWeak.viewModel requestProductListDataOrSearchProductDataWithPage:0 Size:0 Search:nil]delay:1]
         
         subscribeNext:^(NSNumber* x) {
             
             if ([x boolValue]==YES) {
                 
                 [selfWeak.formTabelView reloadData];
             }
             
             else {

                 [MBProgressHUD showText:@"下拉刷新数据加载失败"];
                 
                 //请求数据失败，
             }
             
            [selfWeak.formTabelView.mj_header endRefreshing];
         }];
        
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
            
//            vc.tapDeleteProductBlock = ^() {
//                
//                NSMutableArray *array = [NSMutableArray arrayWithArray:[weakSelf.listDataDic objectForKey:key]];
//                
//                [array removeObjectAtIndex:indexPath.row-1];
//                
//                for (NSString *key in self.keysArray) {
//                    
//                    NSMutableArray *array = [NSMutableArray arrayWithObject:[weakSelf.listDataDic objectForKey:key]];
//                    
//                    if (array.count>0) {
//                        
//                        [weakSelf.isHaveData addObject:@(YES)];
//                    }
//                    
//                    else {
//                        
//                        [weakSelf.isHaveData addObject:@(NO)];
//                    }
//                    
//                }
//                
//                if ([weakSelf.isHaveData containsObject:@(YES)]) {
//                    
//                    [weakSelf.formTabelView reloadData];
//                }
//                
//                else {
//                     weakSelf.formTabelView.hidden = YES;
//                }
//      
//            };
        };
    }
    
    return cell;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CostManagerListHeaderView *headerView =[[[NSBundle mainBundle]loadNibNamed:@"CostManagerListHeaderView" owner:nil options:nil]lastObject];
    
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
