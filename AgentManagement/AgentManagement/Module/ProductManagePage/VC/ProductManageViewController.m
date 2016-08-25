//
//  ProductManageViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "ProductManageViewController.h"
#import "ProductManagerCell.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
@interface ProductManageViewController ()//<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *formTabelView;

@property (weak, nonatomic) IBOutlet UIView *formHeaderView;

@property(nonatomic,strong)   NSMutableArray *array;

@end

@implementation ProductManageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //如果点击了保存按钮
//    if (self.optionResultDic.count > 0) {
//        
//        self.formTabelView.hidden = NO;
//        
//        self.formHeaderView.hidden = NO;
//        
//    }
//
    //插入数据库
    
    NSLog(@"%@",[[DataCacheManager shareDataCacheManager]getOptionResult]);
    self.array=[[DataCacheManager shareDataCacheManager]getOptionResult];
    
    NSLog(@"%@",self.array);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return self.optionResultDic.count;
    
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CellId";
    
     ProductManagerCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell =[[ProductManagerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}



@end
