//
//  SearchMenuViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "SearchMenuViewController.h"
#import "MenuCollectionViewCell.h"
@interface SearchMenuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *MenuCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLaout;
@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation SearchMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor clearColor];
    self.flowLaout.itemSize = CGSizeMake((ScreenWidth-75)/3, 40);
    
    _dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (_dataArray.count %3 <2) {
        
           return _dataArray.count+2;
    }
    else {
        
        return _dataArray.count;
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
    }

    else if (_dataArray.count == indexPath.row-1) {
        
        cell.optionLabel.text =@"";
        cell.optionLabel.backgroundColor=[UIColor clearColor];
    }
    
    else {
        
        cell.optionLabel.text = _dataArray[indexPath.row-1];
    }
    

    
    return cell;


}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSLog(@"点击了第%ld个单元格",indexPath.row);
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
