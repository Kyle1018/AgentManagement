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
@end

@implementation ProductManageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self requestData];
    
    [self observeData];
    
  //
//    [[_viewModel requstAddProductData:nil]subscribeNext:^(id x) {
//       
//        
//    }];
//
//    [[_viewModel requestProductRelatedInformationData]subscribeNext:^(id x) {
//        
//    }];
//
 
    
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
    
//    NSLog(@"%@",[[DataCacheManager shareDataCacheManager]getOptionResult]);
//    self.array=[[DataCacheManager shareDataCacheManager]getOptionResult];
//    
//    NSLog(@"%@",self.array);
}

#pragma mark - Data
- (void)requestData {
  
    _viewModel = [[ProductManageViewModel alloc]init];

     __weak typeof(self) weakSelf = self;
    
//    [[[self.viewModel requstProductInformationData]filter:^BOOL(RACTuple* value) {
//        
//        if ([[value first]boolValue] == YES && [[value second]boolValue] == YES) {
//            
//            return YES;
//        }
//        else {
//            
//            return NO;
//        }
//    }]subscribeNext:^(RACTuple* x) {
//        //刷新表视图
//        [weakSelf.formTabelView reloadData];
//    }];

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
}

- (void)observeData {
    
    __weak typeof(self) weakSelf = self;
//
//    [RACObserve(self.viewModel, productAndModelArray)subscribeNext:^(NSMutableArray* x) {
//       
//        weakSelf.brandAndPmodelDataArray = x;
//        NSLog(@"%@",weakSelf.brandAndPmodelDataArray);
//    }];
    
    NSLog(@"%@",self.userModel);
    
    [RACObserve(self.viewModel, productRelatedInformationArray)subscribeNext:^(NSMutableArray* x) {
        
        weakSelf.productRelatedInformationArray = x;
        
    }];
    
    [RACObserve(self, userModel)subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
    }];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"ProductManageCellId";
        
    ProductManageTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
    if (!cell) {
            
        cell =[[ProductManageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }        
    return cell;
}

#pragma mark - Action
- (IBAction)searchMenuAction:(UIButton *)sender {

    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
    _searchMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchMenuViewID"];
  //  _searchMenuVC.brandAndModelDataArray = self.brandAndPmodelDataArray;
    _searchMenuVC.productRelatedInformationArray = self.productRelatedInformationArray;
    [[UIApplication sharedApplication].keyWindow addSubview:_searchMenuVC.view];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier compare:@"AddProductSegueA"]==NO) {
        
        id page2=segue.destinationViewController;
        [page2 setValue:self.productRelatedInformationArray forKey:@"productRelatedInformationArray"];

    }

}



@end
