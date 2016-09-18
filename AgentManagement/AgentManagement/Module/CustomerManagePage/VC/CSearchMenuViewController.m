//
//  CSearchMenuViewController.m
//  AgentManagement
//
//  Created by huabin on 16/8/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CSearchMenuViewController.h"
@interface CSearchMenuViewController()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *bgView;//背景视图

@property (strong, nonatomic) IBOutlet UIView *cancleView;//取消视图

@end

@implementation CSearchMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.bgView.originX = ScreenWidth;
    
    [self.cancleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenuView)]];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:1 animations:^{
        
        self.bgView.originX = 75;
        
    }];
}

- (void)hideMenuView {
    
    [UIView animateWithDuration:1 animations:^{
        
        self.bgView.originX = ScreenWidth;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self.cancleView removeFromSuperview];
        [self.view removeFromSuperview];
    }];
    
}

#pragma mark -UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = [self creatCellID:indexPath.section];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]init];
  
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 10, 80, 16)];
    label.backgroundColor=[UIColor whiteColor];
    label.textColor = [UIColor colorWithHex:@"4a4a4a"];
    label.font = [UIFont systemFontOfSize:14.f];
    
    if (section==0) {
        
        label.text =@"姓名";
    }
    else if (section==1) {
        
        label.text = @"手机号";
    }
    else {
        label.text = @"城市";
    }
    
    [headerView addSubview:label];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (NSString*)creatCellID:(NSInteger)section {
    
    NSString *cellID = [NSString stringWithFormat:@"SearchMenuCell%ld",section];
    
    return cellID;
}

#pragma mark - Action
//点击了重置按钮
- (IBAction)resetAction:(UIButton *)sender {
}
//点击了确定按钮
- (IBAction)confirmAction:(UIButton *)sender {
}

//点击了选择城市
- (IBAction)SelectCityAction:(UIControl *)sender {
    DDLogDebug(@"点击了选择城市");
}

@end
