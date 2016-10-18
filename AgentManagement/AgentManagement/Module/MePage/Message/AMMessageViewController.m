//
//  AMMessageViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMMessageViewController.h"
#import "AMMessageViewModel.h"
#import "AMMessageTableViewCell.h"

@interface AMMessageViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *messageTableView;

@property (nonatomic, strong) NSArray *messageArray;
@property (nonatomic, strong) AMMessageViewModel *messageViewModel;

@end

@implementation AMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeControl];
    [self refreshMessage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AMMessageViewModel *)messageViewModel {
    if (!_messageViewModel) {
        _messageViewModel = [[AMMessageViewModel alloc] init];
    }
    return _messageViewModel;
}

- (void)initializeControl {
    self.title = @"我的消息";
    
    @weakify(self);
    self.messageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshMessage];
    }];
    
    self.messageTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self loadMoreMessage];
    }];
}

- (void)refreshMessage {
    [[self.messageViewModel refreshMessageSignal] subscribeNext:^(id x) {
        self.messageArray = x;
        [self.messageTableView reloadData];
    } error:^(NSError *error) {
        [self.messageTableView.mj_header endRefreshing];
        [MBProgressHUD showText:@"刷新消息失败"];
    } completed:^{
        [self.messageTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreMessage {
    [[self.messageViewModel loadMoreMessageSignal] subscribeNext:^(id x) {
        self.messageArray = x;
        [self.messageTableView reloadData];
    } error:^(NSError *error) {
        [self.messageTableView.mj_footer endRefreshing];
        [MBProgressHUD showText:@"加载更多消息失败"];
    } completed:^{
        [self.messageTableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMessageCellIdentify];
    
    if (!cell) {
        cell = [AMMessageTableViewCell viewFromXib];
    }
    
    if (indexPath.row < self.messageArray.count) {
        [cell updateWithMessage:self.messageArray[indexPath.row]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.;
    
    if (indexPath.row < self.messageArray.count) {
        height = [AMMessageTableViewCell cellHeightForMessage:self.messageArray[indexPath.row]];
    }
    return height;
}

@end
