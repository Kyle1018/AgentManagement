//
//  DataAnalysisViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/17.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "DataAnalysisViewController.h"
#import "DataAnalysisCell.h"
#import "DataAnalysisViewModel.h"
#import "AMProductInfo.h"
#define CurrentScrrenSize(oldWidth) (oldWidth * (ScreenWidth/375))
@interface DataAnalysisViewController ()
@property(nonatomic,strong)NSMutableArray *yLabels;
@property(nonatomic,strong)NSMutableArray *datasArray;
@property(nonatomic,strong)DataAnalysisViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UITableView *tabelView;
@end

@implementation DataAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _viewModel = [[DataAnalysisViewModel alloc]init];

    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i<12; i++) {
        
        [array addObject:@(0)];
    }
    

    _datasArray = [NSMutableArray arrayWithObjects:@[array,array],array,nil];
    
    [self requestData];

    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        DDLogDebug(@"下拉刷新");
        
        [self.tableView.mj_header endRefreshing];
    }];
    

}


- (void)requestData {
    
    //请求库存量
    [[self.viewModel requestStock]subscribeNext:^(id x) {
        
        if ([x isKindOfClass:[RACTuple class]]) {
            
            RACTuple *tuple = x;
            NSLog(@"dd");
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:_datasArray[0]];
            [array replaceObjectAtIndex:0 withObject:[tuple first]];
            [array replaceObjectAtIndex:1 withObject:[tuple second]];
            [_datasArray replaceObjectAtIndex:0 withObject:array];

        }
        else {
    
            [_datasArray replaceObjectAtIndex:1 withObject:x];
            NSLog(@"xx");
        }
        
        [self.tabelView reloadData];
        
        /*
        NSMutableArray *array = [NSMutableArray arrayWithArray:_datasArray[0]];
        [array replaceObjectAtIndex:0 withObject:x];
        [_datasArray replaceObjectAtIndex:0 withObject:array];
        [self.tabelView reloadData];
         */
    }];
    
    //请求销售量
    /*
    [[self.viewModel requestLSalesVolume]subscribeNext:^(NSMutableArray* x) {
        
        NSLog(@"%@",x);
        NSMutableArray *array = [NSMutableArray arrayWithArray:_datasArray[0]];
        [array replaceObjectAtIndex:1 withObject:x];
           [_datasArray replaceObjectAtIndex:0 withObject:array];
        [self.tabelView reloadData];
        
    }];
     */
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CurrentScrrenSize(227);
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"DataAnalysisCellId";
    
    DataAnalysisCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        
        cell = [[DataAnalysisCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    
    [cell setDataWithXLabels:@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"] YLabels: @[@[
                                                                                                                          @"0",
                                                                                                                          @"200",
                                                                                                                          @"400",
                                                                                                                          @"600",
                                                                                                                          @"800",
                                                                                                                          @"1000",
                                                                                                                          ],@[@"0",
                                                                                                                              @"50",
                                                                                                                              @"100",
                                                                                                                              @"150",
                                                                                                                              @"200",
                                                                                                                              @"250",
                                                                                                                              @"300",
                                                                                                                              ]][indexPath.section] datasArray:_datasArray[indexPath.section]sectionIndex:indexPath.section];
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerview = [[UIView alloc]init];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,0,ScreenWidth, 40)];
    titleLabel.font = [UIFont systemFontOfSize:15.f];
    titleLabel.textColor = [UIColor colorWithHex:@"000000"];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [headerview addSubview:titleLabel];
    if (section == 0) {
        
        titleLabel.text = @"库存和销售数据";
    }
    else {
        
        titleLabel.text = @"全年销售额";
    }

    return headerview;
}

@end
