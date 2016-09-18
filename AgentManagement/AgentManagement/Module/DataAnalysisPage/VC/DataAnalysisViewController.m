//
//  DataAnalysisViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/17.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "DataAnalysisViewController.h"
#import "DataAnalysisCell.h"
@interface DataAnalysisViewController ()
@property(nonatomic,strong)NSArray *xLabels;

@property(nonatomic,strong)NSMutableArray *yLabels;

@property(nonatomic,strong)NSMutableArray *datasArray;
@end

@implementation DataAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getData];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        DDLogDebug(@"下拉刷新");
        
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)getData {
    
    _xLabels = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    
    _yLabels = [NSMutableArray arrayWithObjects: @[
                                                    @"0",
                                                        @"50",
                                                        @"100",
                                                        @"150",
                                                        @"200",
                                                        @"250",
                                                    ],@[@"0",
                                                        @"200",
                                                        @"400",
                                                        @"600",
                                                        @"800",
                                                        @"1000",
                                                        @"1200",
                                                        ],nil];
 
    
    _datasArray = [NSMutableArray arrayWithObjects:@[@[@11,@0,@66,@34,@101,@123,@134,@219,@176,@77,@90,@12],@[@155,@67,@200,@33,@92,@76,@88,@177,@232,@201,@99,@32]],@[@60.1, @160.1, @126.4, @0.0, @186.2, @127.2, @176.2,@1000,@500,@688,@0,@29],nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    return  (ScreenHeight-49-64-self.tableView.numberOfSections*30)/2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"DataAnalysisCellId";
    
    DataAnalysisCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        
        cell = [[DataAnalysisCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
 
//
    
//    if (indexPath.section == ) {
//        
        [cell setDataWithXLabels:_xLabels YLabels:_yLabels[indexPath.section] datasArray:_datasArray[indexPath.section]sectionIndex:indexPath.section];
        
//    }
//    else {
//        
//        
//    }
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
