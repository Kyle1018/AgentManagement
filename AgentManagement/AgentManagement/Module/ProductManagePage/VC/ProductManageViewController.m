//
//  ProductManageViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "ProductManageViewController.h"
#import "ProductManageTableViewCell.h"
#import "SearchMenuViewController.h"
#import "ProductManageViewModel.h"
#import "ProductDetailViewController.h"
@interface ProductManageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *formTabelView;

@property (weak, nonatomic) IBOutlet UIView *formHeaderView;

@property(nonatomic,strong)   NSMutableArray *array;

@property(nonatomic,strong)ProductManageViewModel *viewModel;


@property(nonatomic,strong)SearchMenuViewController*searchMenuVC;
@end

@implementation ProductManageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//
//    _viewModel = [[ProductManageViewModel alloc]init];
//    
//    [[_viewModel requestProductRelatedInformationData]subscribeNext:^(id x) {
//        
//    }];
//    
//    [[_viewModel requestProductAndModelListData]subscribeNext:^(id x) {
//        
//    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //如果点击了保存按钮
//    if (self.optionResultDic.count > 0) {
//        
//        self.formTabelView.hidden = NO;
//        
//        self.formHeaderView.hidden = NO;
//        
//    }
//
    //插入数据库
    
    NSLog(@"%@",[[DataCacheManager shareDataCacheManager]getOptionResult]);
    self.array=[[DataCacheManager shareDataCacheManager]getOptionResult];
    
    NSLog(@"%@",self.array);
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 10;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"ProductManageCellId";
        
    ProductManageTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
    if (!cell) {
            
        cell =[[ProductManageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.tapSeeDetailBlock = ^() {
      
        ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc]init];
        
        [self.navigationController pushViewController:productDetailVC animated:YES];
        
    };
        
    return cell;
}

- (IBAction)searchMenuAction:(UIButton *)sender {

    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
    _searchMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchMenuViewID"];
    [[UIApplication sharedApplication].keyWindow addSubview:_searchMenuVC.view];
}

@end
