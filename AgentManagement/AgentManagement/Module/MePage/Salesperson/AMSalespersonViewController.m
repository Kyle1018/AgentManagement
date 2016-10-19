//
//  AMSalespersonViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMSalespersonViewController.h"
#import "AMSalespersonTableViewCell.h"
#import "AMSalespersonViewModel.h"
#import "AMSalespersonDetailViewController.h"
#import "AMSearchSalespersonView.h"

@interface AMSalespersonViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *salespersonTableView;
@property (nonatomic, strong) AMSearchSalespersonView *searchView;

@property (nonatomic, strong) NSMutableArray *salespersonArray;
@property (nonatomic, strong) AMSalespersonViewModel *salespersonViewModel;

@end

@implementation AMSalespersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeControl];
    [self refreshSalesperson];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AMSalespersonViewModel *)salespersonViewModel {
    if (!_salespersonViewModel) {
        _salespersonViewModel = [[AMSalespersonViewModel alloc] init];
    }
    return _salespersonViewModel;
}

- (NSMutableArray *)salespersonArray {
    if (!_salespersonArray) {
        _salespersonArray = [NSMutableArray array];
    }
    return _salespersonArray;
}

- (void)initializeControl {
    self.title = @"销售员管理";
    
    [self initializeNavigation];
    
    @weakify(self);
    self.salespersonTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshSalesperson];
    }];
    
    self.salespersonTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self loadMoreSalesperson];
    }];
}

- (void)initializeNavigation {
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Add"] style:UIBarButtonItemStylePlain target:self action:@selector(addSalespersonItemPressed)];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchItemPressed)];
    
    self.navigationController.navigationItem.rightBarButtonItems = @[addItem, searchItem];
}

- (void)addSalespersonItemPressed {
    [self.navigationController pushViewController:[[AMSalespersonDetailViewController alloc] init] animated:YES];
}

- (void)searchItemPressed {
    if (!self.searchView) {
        self.searchView = [[AMSearchSalespersonView alloc] initWithFrame:CGRectMake(0., 0., self.view.width, (self.view.height - 64.))];
        @weakify(self);
        self.searchView.searchBlock = ^(NSString *name, NSString *phone, NSString *area) {
            @strongify(self);
            [self searchWithName:name phone:phone area:area];
        };
    }
    
    if (self.searchView.superview) {
        [self.searchView removeFromSuperview];
    } else {
        [self.view addSubview:self.searchView];
    }
}

- (void)buildArrayWithSalespersons:(NSArray *)salespersons {
    [self.salespersonArray removeAllObjects];
    AMSales *titleSales = [[AMSales alloc] init];
    
    titleSales.name = @"销售姓名";
    titleSales.phone = @"手机号";
    [self.salespersonArray addObject:titleSales];
    if (salespersons.count > 0) {
        [self.salespersonArray addObjectsFromArray:salespersons];
    }
}

- (void)refreshSalesperson {
    [[self.salespersonViewModel refreshSalespersonSignal] subscribeNext:^(id x) {
        [self buildArrayWithSalespersons:x];
        [self.salespersonTableView reloadData];
    } error:^(NSError *error) {
        [self.salespersonTableView.mj_header endRefreshing];
        [MBProgressHUD showText:@"刷新销售员列表失败"];
    } completed:^{
        [self.salespersonTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreSalesperson {
    [[self.salespersonViewModel loadMoreSalespersonSignal] subscribeNext:^(id x) {
        [self buildArrayWithSalespersons:x];
        [self.salespersonTableView reloadData];
    } error:^(NSError *error) {
        [self.salespersonTableView.mj_footer endRefreshing];
        [MBProgressHUD showText:@"加载更多销售员列表失败"];
    } completed:^{
        [self.salespersonTableView.mj_footer endRefreshing];
    }];
}

- (void)searchWithName:(NSString *)name phone:(NSString *)phone area:(NSString *)area {
#warning 搜索
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.salespersonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMSalespersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSalespersonCellIdentifier];
    
    if (!cell) {
        cell = [AMSalespersonTableViewCell viewFromXib];
        @weakify(self);
        cell.tapSalespersonDetail = ^(AMSales *sales) {
            @strongify(self);
            AMSalespersonDetailViewController *detailViewController = [[AMSalespersonDetailViewController alloc] init];
            
            detailViewController.sales = sales;
            [self.navigationController pushViewController:detailViewController animated:YES];
        };
    }
    
    if (indexPath.row < self.salespersonArray.count) {
        [cell updateWithSales:self.salespersonArray[indexPath.row] isTitle:(indexPath.row == 0)];
        [cell setBottomLineShown:(indexPath.row == (self.salespersonArray.count - 1))];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42.;
}

@end
