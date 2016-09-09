//
//  SearchMenuViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "PSearchMenuViewController.h"
#import "MenuCollectionViewCell.h"
#import "MenuHeaderView.h"
#import "AMProductAndModel.h"
#import "AMProductRelatedInformation.h"
@interface PSearchMenuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *MenuCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLaout;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *cancelView;

@property(nonatomic,strong)NSMutableArray *heaerDataArray;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong) NSArray *array;

@property(nonatomic,strong)NSMutableArray *isExpland;

@property(nonatomic,strong)NSIndexPath *lastIndexPath;

@property(nonatomic,assign)NSInteger optionLabelTag;

@property(nonatomic,strong)NSMutableArray *indexPathArray;

@property(nonatomic,strong)NSMutableSet *set;

@end

@implementation PSearchMenuViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _set = [NSMutableSet set];

    NSLog(@"%@",self.productRelatedInformationArray);
    
    self.view.backgroundColor=[UIColor clearColor];
    
    self.bgView.originX = ScreenWidth;

    _optionLabelTag = 2000;
    
    [self.cancelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenuView)]];
    
    self.flowLaout.itemSize = CGSizeMake((ScreenWidth-75)/3, 48);

    [self configData];
    
    for (int i = 0; i< self.dataArray.count; i++) {
        
        NSArray *a = self.dataArray[i];
        
        NSMutableArray *dd = [NSMutableArray arrayWithArray:a];
        
        [dd insertObject:@"不限" atIndex:0];
        
        [self.dataArray replaceObjectAtIndex:i withObject:dd];
    }
 
    
    NSLog(@"%@",self.dataArray);
    
    _indexPathArray = [NSMutableArray array];
    
    for (int i = 0; i<self.dataArray.count; i++) {
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:i];
        
        [_indexPathArray addObject:path];
    }
    

}

- (void)configData {

    self.dataArray = [NSMutableArray array];
    
    self.isExpland = [NSMutableArray array];
    
    self.heaerDataArray = [NSMutableArray arrayWithObjects:@"品牌",@"型号", nil];
    
    [self.heaerDataArray addObjectsFromArray:[self.productRelatedInformationArray firstObject]];
    
    [self.dataArray addObjectsFromArray:[self.productRelatedInformationArray lastObject]];
    
    //用0代表收起，非0代表展开，默认都是收起的
    for (int i = 0; i < self.dataArray.count; i++) {
        [self.isExpland addObject:@0];
    }
    
    [self.MenuCollectionView reloadData];
}


- (void)viewWillAppear:(BOOL)animated {
    
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
    
    else {
        
        if (array.count >= 1) {
            
            return 3;
        }
        else {
            
            return array.count;
        }
    }
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuCollectionViewCell *cell = nil;

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
    
    //占位单元格
    if (array.count <= indexPath.row) {
        
        [cell setTitleData:@"" color:[UIColor clearColor]];
    }

    //选项单元格
    else {

       [cell setTitleData:self.dataArray[indexPath.section][indexPath.row] color:[_indexPathArray containsObject:indexPath]?[UIColor blueColor]:[UIColor grayColor]];
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
            [self.MenuCollectionView reloadSections:set];
        };
        
        reusableview = headerView;
    }
    
    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    for (int i = 0; i< _indexPathArray.count; i++) {
        
        NSIndexPath *path = _indexPathArray[i];
        
        if (path.section == indexPath.section) {
            
                [_indexPathArray removeObject:path];
            
                [_indexPathArray addObject:indexPath];
                        
        }
    }
    
//    for (NSIndexPath *path in _indexPathArray) {
//    
//        if (path.section == indexPath.section) {
//            
//            [_indexPathArray removeObject:path];
//            
//            [_indexPathArray addObject:indexPath];
//            
//        }
//        else {
//            
//            
//        }
//        
//    
//    }
    
    
//    if (_lastIndexPath.section == indexPath.section) {
//        
//        
//        [_indexPathArray removeObject:_lastIndexPath];
//        
//        [_indexPathArray addObject:indexPath];
//    }
//    else {
//        
//        [_indexPathArray addObject:indexPath ];
//        
//    }
// 
    _lastIndexPath = indexPath;
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
    [self.MenuCollectionView reloadSections:set];


}

#pragma mark -Action
//重置
- (IBAction)resetAction:(UIButton *)sender {
    
    _lastIndexPath = nil;
    
    _optionLabelTag = 2000;
    
    [self.MenuCollectionView reloadData];
}

//确定
- (IBAction)confirmAction:(UIButton *)sender {
    
    [UIView animateWithDuration:1 animations:^{
        
        self.bgView.originX = ScreenWidth;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self.cancelView removeFromSuperview];
        [self.view removeFromSuperview];
    }];
    
}

@end
