//
//  AMLogViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMLogViewController.h"
#import "AMLogViewModel.h"
#import "AMLogTableViewCell.h"
#import "AMLogDetailViewController.h"

@interface AMLogViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *logTableView;

@property (nonatomic, strong) NSMutableArray *logArray;
@property (nonatomic, strong) AMLogViewModel *logViewModel;

@end

@implementation AMLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeControl];
    [self refreshLog];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)logArray {
    if (!_logArray) {
        _logArray = [NSMutableArray array];
    }
    return _logArray;
}

- (AMLogViewModel *)logViewModel {
    if (!_logViewModel) {
        _logViewModel = [[AMLogViewModel alloc] init];
    }
    return _logViewModel;
}

- (void)initializeControl {
    self.title = @"操作日志";
    
    [self buildLogArrayWithLogs:nil];
    [self.logTableView reloadData];
    
    @weakify(self);
    self.logTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshLog];
    }];
    
    self.logTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self loadMoreLog];
    }];
}

- (void)buildLogArrayWithLogs:(NSArray *)logs {
    [self.logArray removeAllObjects];
    AMLog *titleLog = [[AMLog alloc] init];
#warning 处理log
    [self.logArray addObject:titleLog];
    if (logs.count > 0) {
        [self.logArray addObjectsFromArray:logs];
    }
}

- (void)refreshLog {
    [[self.logViewModel refreshLogSignal] subscribeNext:^(id x) {
        [self buildLogArrayWithLogs:x];
        [self.logTableView reloadData];
    } error:^(NSError *error) {
        [self.logTableView.mj_header endRefreshing];
        [MBProgressHUD showText:@"刷新日志失败"];
    } completed:^{
        [self.logTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreLog {
    [[self.logViewModel loadMoreLogSignal] subscribeNext:^(id x) {
        [self buildLogArrayWithLogs:x];
        [self.logTableView reloadData];
    } error:^(NSError *error) {
        [self.logTableView.mj_footer endRefreshing];
        [MBProgressHUD showText:@"加载更多日志失败"];
    } completed:^{
        [self.logTableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLogCellIdentifier];
    
    if (!cell) {
        cell = [AMLogTableViewCell viewFromXib];
        @weakify(self);
        cell.tapLogDetail = ^(AMLog *log) {
            @strongify(self);
            if (!log.isTitleLog) {
                AMLogDetailViewController *detailViewController = [[AMLogDetailViewController alloc] init];
                
                detailViewController.log = log;
                [self.navigationController pushViewController:detailViewController animated:YES];
            }
        };
    }
    
    if (indexPath.row < self.logArray.count) {
        [cell updateWithLog:self.logArray[indexPath.row] isBold:(indexPath.row == 0)];
        [cell setBottomLineShown:(indexPath.row == (self.logArray.count - 1))];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42.;
}

@end
