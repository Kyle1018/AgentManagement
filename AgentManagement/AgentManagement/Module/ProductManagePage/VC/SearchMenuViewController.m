//
//  SearchMenuViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "SearchMenuViewController.h"
#import "MenuCollectionViewCell.h"
#import "MenuHeaderView.h"
@interface SearchMenuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *MenuCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLaout;

@property(nonatomic,strong)NSArray *heaerDataArray;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *cancelView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong) NSArray *array;

@property(nonatomic,strong)NSMutableArray *isExpland;
@end

@implementation SearchMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor clearColor];
    
    self.bgView.originX = ScreenWidth;
    

    
    [self.cancelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenuView)]];
    
    self.flowLaout.itemSize = CGSizeMake((ScreenWidth-75)/3, 48);
    
    _heaerDataArray = @[@"品牌",@"型号",@"直接饮用",@"过滤介质",@"产品特点",@"摆放位置",@"滤芯个数",@"适用地区",@"零售价格",@"换芯周期"];
//    
   _array  = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
    // Do any additional setup after loading the view.
    
    /*
     品牌、型号、分类、直接饮用、过滤介质、产品特点、摆放位置、滤芯个数、适用地区、零售价格、换芯周期
     */
       _dataArray= [NSMutableArray array];
    [_dataArray addObjectsFromArray:_array ];
    

    if (_array.count>0 && _array.count <2) {
        
        
        [_dataArray addObject:[_array firstObject]];
    }
    
    else if (_array.count >0 && _array.count>1) {
        
        [_dataArray addObject:_array[0]];
        [_dataArray addObject:_array[1]];
    }
    
    


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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UICollectionViewDelegate;UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (_dataArray.count %3 == 0) {
        
        return _dataArray.count +3;
    }
    else if (_dataArray.count %3 == 1) {
        
        return _dataArray.count+2;
    }
    else {
        
        return _dataArray.count+1;
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
    
    if (indexPath.row == 0) {
        
        cell.optionLabel.text = @"不限";
        cell.optionLabel.backgroundColor=[UIColor colorWithHex:@"f1f1f1"];
    }


    else if (_dataArray.count <= indexPath.row-1) {
        
        
        
        cell.optionLabel.text =@"";
        cell.optionLabel.backgroundColor=[UIColor clearColor];
    }
    
    else {
        
        cell.optionLabel.text = _dataArray[indexPath.row-1];
        cell.optionLabel.backgroundColor=[UIColor colorWithHex:@"f1f1f1"];
    }
    
    return cell;
}

//设置头视图
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        MenuHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CellHeaderID" forIndexPath:indexPath];
        
        
        headerView.hederTitle.text = _heaerDataArray[indexPath.section];
        
        __weak typeof(self) weakSelf = self;
        
        //点击全部按钮回调
        headerView.tapAllButonBlock = ^() {
            
            NSLog(@"点击了全部按钮");
            [_dataArray removeAllObjects];
            [_dataArray addObjectsFromArray:_array];
      
            [weakSelf.MenuCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        };
        
        reusableview = headerView;
    }
    
    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSLog(@"点击了第%ld个单元格",(long)indexPath.row);
}

@end
