//
//  CoSearchMenuViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CoSearchMenuViewController.h"
#import "MenuHeaderView.h"
#import "MenuCollectionViewCell.h"
#import "ProductManageViewModel.h"
@interface CoSearchMenuViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *menuCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLaout;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *cancelView;

@property(nonatomic,strong)NSArray *heaerDataArray;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSMutableArray *isExpland;

@property(nonatomic,strong)NSIndexPath *lastIndexPath;

@property(nonatomic,strong)NSMutableArray *indexPathArray;

@property(nonatomic,strong)NSMutableDictionary *selectedOptionDic;
@property(nonatomic,strong)ProductManageViewModel *viewModel;

@end

@implementation CoSearchMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DDLogDebug(@"%@",self.brandAndPmodelDataArray);
    
    self.bgView.originX = ScreenWidth;

    
    [self.cancelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenuView)]];
    
    [self requstData];
    
      _selectedOptionDic = [NSMutableDictionary dictionary];
    
    _viewModel = [[ProductManageViewModel alloc]init];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:1 animations:^{
        
        self.bgView.originX = 75;
        
    }];
}


- (void)requstData {

     self.isExpland = [NSMutableArray array];
    
    //默认将每组第0个indexpath插入数组，用于开始时默认显示选中不限
    _indexPathArray = [NSMutableArray array];
    
    self.heaerDataArray = @[@"品牌",@"型号",@"进货时间"];
    
    self.dataArray = [NSMutableArray arrayWithObjects:self.brandAndPmodelDataArray[0],self.brandAndPmodelDataArray[1],@[@"dd",@"dd"], nil];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:i];
        
        [_indexPathArray addObject:path];//将每组第0个indexpath存入数组
        
        NSArray *array = self.dataArray[i];//获取每组中的内容数组
        
        NSMutableArray *contentArray = [NSMutableArray arrayWithArray:array];
        
        [contentArray insertObject:@"不限" atIndex:0];//将“不限”选项插入每组选项数组的第一个元素
        
        [self.dataArray replaceObjectAtIndex:i withObject:contentArray];
        
        [self.isExpland addObject:@0]; //用0代表收起，非0代表展开，默认都是收起的
    }
}

- (void)hideMenuView {
    
    [UIView animateWithDuration:1 animations:^{
        
        self.bgView.originX = ScreenWidth;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self.cancelView removeFromSuperview];
        [self.view removeFromSuperview];
    }];
    
}


#pragma mark -UICollectionViewDelegate;UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.heaerDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSArray *array = self.dataArray[section];
    
    if (section != 2) {
        
        if ([self.isExpland[section] boolValue]) {
            
            if (array.count%3==0) {
                
                return array.count;
            }
            else if (array.count%3==1) {
                
                return array.count+2;
            }
            else if (array.count%3==2) {
                
                return array.count+1;
            }
            else {
                
                return 0;
            }
        }
        
        //单元格没有展开的时候
        else {
            
            if (array.count >= 1) {
                
                return 3;
            }
            else {
                
                return array.count;//如果选项数量为1或者2时，就直接显示选项
            }
        }
        
    }
    
    else {
        
        return 1;
    }
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     MenuCollectionViewCell *cell = nil;
    
    if (indexPath.section != 2) {
        
        //创建3个不同的单元格，便于布局
        if (indexPath.row%3==0) {
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIDL" forIndexPath:indexPath];
        }
        
        else if (indexPath.row%3==1) {
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIDM" forIndexPath:indexPath];
            
        }
        
        else if (indexPath.row%3==2) {
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIDR" forIndexPath:indexPath];
        }
        
        
        NSArray *array = self.dataArray[indexPath.section];
        
        if (array.count <= indexPath.row) {
            
            [cell setTitleData:@"占位" backgroundColor:[UIColor clearColor] titleColor:[UIColor clearColor]];
        }
        else {
            
            [cell setTitleData:self.dataArray[indexPath.section][indexPath.row] backgroundColor:[_indexPathArray containsObject:indexPath]?[UIColor colorWithHex:@"47b6ff"]:[UIColor colorWithHex:@"f1f1f1"] titleColor:[_indexPathArray containsObject:indexPath]?[UIColor colorWithHex:@"ffffff"]:[UIColor colorWithHex:@"4a4a4a"]];
        }
        
    }
    
    else {
        
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellTimerID" forIndexPath:indexPath];

        
        
        [[[[cell.addTimeTextField rac_textSignal]distinctUntilChanged]filter:^BOOL(NSString* value) {
            
            if (value.length>0) {
                
                return YES;
            }
            else {
                
                return NO;
            }
            
        }]subscribeNext:^(id x) {
            
            [_selectedOptionDic safeSetObject:x forKey:@"add_time"];
        }];
        
        [cell setTitleData:@"输入框" backgroundColor:[UIColor clearColor] titleColor:[UIColor clearColor]];
        
    }
 

    return cell;
}

//设置头视图
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        MenuHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CellHeaderID" forIndexPath:indexPath];
        
        [headerView setTitle:_heaerDataArray[indexPath.section]];
        
        //点击全部按钮回调
        headerView.tapAllButonBlock = ^() {
            
            //纪录展开的状态
            self.isExpland[indexPath.section] = [self.isExpland[indexPath.section] isEqual:@0]?@1:@0;
            //刷新点击的section
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
            [self.menuCollectionView reloadSections:set];
        };
        
        reusableview = headerView;
    }
    
    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    

    UITextField *texField = [collectionView viewWithTag:2000];
    
    [texField resignFirstResponder];
    
    for (int i = 0; i< _indexPathArray.count; i++) {
        
        NSIndexPath *path = _indexPathArray[i];
        
        if (path.section == indexPath.section) {
            
            NSString *str = self.dataArray[indexPath.section][indexPath.row];
            
            if ([str isEqualToString:@"不限"]) {
                
                [_selectedOptionDic removeObjectForKey:[self.viewModel textChangeToKey:self.heaerDataArray[indexPath.section]]];
            }
            else {
                
                [_selectedOptionDic safeSetObject:str forKey:[self.viewModel textChangeToKey:self.heaerDataArray[indexPath.section]]];
            }
            
            
            [_indexPathArray removeObject:path];
            [_indexPathArray addObject:indexPath];
            
        }
    }
    
    _lastIndexPath = indexPath;
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
    [self.menuCollectionView reloadSections:set];

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section != 2) {
        
        return  CGSizeMake((ScreenWidth-75)/3, 48);
    }
    
    else {
        
        return CGSizeMake(ScreenWidth-75, 48);
    }
}

#pragma mark -Action
//重置
- (IBAction)resetAction:(UIButton *)sender {
    
    [_indexPathArray removeAllObjects];
    
    [_selectedOptionDic removeAllObjects];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:i];
        
        [_indexPathArray addObject:path];//将每组第0个indexpath存入数组
    }
    
    _lastIndexPath = nil;
    
    [self.menuCollectionView reloadData];
}

//确定
- (IBAction)confirmAction:(UIButton *)sender {

    if (self.tapSearchProductBlock) {
        
        self.tapSearchProductBlock(self.selectedOptionDic);
    }
    
    [UIView animateWithDuration:1 animations:^{
        
        self.bgView.originX = ScreenWidth;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self.cancelView removeFromSuperview];
        [self.view removeFromSuperview];
    }];
    
}
@end
