//
//  AMAdministatorViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAdministatorViewController.h"
#import "AMAdministratorViewModel.h"
#import "AMAdministratorTableViewCell.h"
#import "AMAdministratorDetailViewController.h"
#import "AMSearchAdministratorView.h"
#import "AMAdministratorListRequest.h"
#import "AMAddAdministratorRequest.h"
#import "AMModifyAdministratorRequest.h"

@interface AMAdministatorViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *administratorTableView;
@property (nonatomic, strong) AMSearchAdministratorView *searchView;

@property (nonatomic, strong) AMAdministratorViewModel *administratorViewModel;
@property (nonatomic, strong) NSMutableArray *administratorArray;

@property (nonatomic, strong) AMAdministratorListRequest *request;
@property (nonatomic, strong) AMAddAdministratorRequest *request1;
@property (nonatomic, strong) AMModifyAdministratorRequest *request2;

@end

@implementation AMAdministatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeControl];
//    [self refreshAdministrator];
    self.request = [[AMAdministratorListRequest alloc] initWithPageIndex:1 pageSize:10 name:nil phone:nil area:nil];
    
    [self.request requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
        NSLog(@"%@", model);
    } failure:^(KKBaseModel *model, KKRequestError *error) {
        NSLog(@"faf");
    }];
    
    self.request1 = [[AMAddAdministratorRequest alloc] initWithNickname:@"fdjal" phone:@"18500326684" area:@"北京"];
    [self.request1 requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
        NSLog(@"%@", model);
    } failure:^(KKBaseModel *model, KKRequestError *error) {
        NSLog(@"fda");
    }];
    
    self.request2 = [[AMModifyAdministratorRequest alloc] initWithAdministratorID:@"25" nickname:@"fdaf" phone:@"18500326684" area:@"1"];
    [self.request2 requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
        NSLog(@"%@", model);
    } failure:^(KKBaseModel *model, KKRequestError *error) {
        NSLog(@"fda");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AMAdministratorViewModel *)administratorViewModel {
    if (!_administratorViewModel) {
        _administratorViewModel = [[AMAdministratorViewModel alloc] init];
    }
    return _administratorViewModel;
}

- (NSMutableArray *)administratorArray {
    if (!_administratorArray) {
        _administratorArray = [NSMutableArray array];
    }
    return _administratorArray;
}

- (void)initializeControl {
    self.title = @"管理员管理";
    
    [self initializeNavigation];
    
    @weakify(self);
    self.administratorTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshAdministrator];
    }];
    
    self.administratorTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self loadMoreAdministrator];
    }];
}

- (void)initializeNavigation {
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Add"] style:UIBarButtonItemStylePlain target:self action:@selector(addSalespersonItemPressed)];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchItemPressed)];
    
    self.navigationController.navigationItem.rightBarButtonItems = @[addItem, searchItem];
}

- (void)addSalespersonItemPressed {
    [self.navigationController pushViewController:[[AMAdministratorDetailViewController alloc] init] animated:YES];
}

- (void)searchItemPressed {
    if (!self.searchView) {
        self.searchView = [[AMSearchAdministratorView alloc] initWithFrame:CGRectMake(0., 0., self.view.width, (self.view.height - 64.))];
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

- (void)buildArrayWithAdministrators:(NSArray *)administrators {
    [self.administratorArray removeAllObjects];
    AMAdministrators *titleAdministrator = [[AMAdministrators alloc] init];
    
    titleAdministrator.nickname = @"客户姓名";
    titleAdministrator.username = @"手机号";
    [self.administratorArray addObject:titleAdministrator];
    if (administrators.count > 0) {
        [self.administratorArray addObjectsFromArray:administrators];
    }
}

- (void)refreshAdministrator {
    [[self.administratorViewModel refreshAdministratorSignal] subscribeNext:^(id x) {
        [self buildArrayWithAdministrators:x];
        [self.administratorTableView reloadData];
    } error:^(NSError *error) {
        [self.administratorTableView.mj_header endRefreshing];
        [MBProgressHUD showText:@"刷新管理员列表失败"];
    } completed:^{
        [self.administratorTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreAdministrator {
    [[self.administratorViewModel loadMoreAdministratorSignal] subscribeNext:^(id x) {
        [self buildArrayWithAdministrators:x];
        [self.administratorTableView reloadData];
    } error:^(NSError *error) {
        [self.administratorTableView.mj_footer endRefreshing];
        [MBProgressHUD showText:@"加载更多管理员列表失败"];
    } completed:^{
        [self.administratorTableView.mj_footer endRefreshing];
    }];
}

- (void)searchWithName:(NSString *)name phone:(NSString *)phone area:(NSString *)area {
#warning 搜索
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.administratorArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMAdministratorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAdministratorCellIdentifier];
    
    if (!cell) {
        cell = [AMAdministratorTableViewCell viewFromXib];
        @weakify(self);
        cell.tapAdministratorDetail = ^(AMAdministrators *administrator) {
            @strongify(self);
            AMAdministratorDetailViewController *detailViewController = [[AMAdministratorDetailViewController alloc] init];
            
            detailViewController.administrator = administrator;
            [self.navigationController pushViewController:detailViewController animated:YES];
        };
    }
    
    if (indexPath.row < self.administratorArray.count) {
        [cell updateWithAdministrator:self.administratorArray[indexPath.row] isTitle:(indexPath.row == 0)];
        [cell setBottomLineShown:(indexPath.row == (self.administratorArray.count - 1))];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42.;
}

@end
