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

#import "SearchMenuViewController.h"
#define KFormTabelView tableView.tag == 1000
#define KMenuTabelView tableView.tag == 1001


@interface ProductManageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *formTabelView;

@property (weak, nonatomic) IBOutlet UIView *formHeaderView;

@property(nonatomic,strong)   NSMutableArray *array;



@property(nonatomic,strong)SearchMenuViewController*searchMenuVC;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (KFormTabelView) {
        
        return 0;
    }
    
    else if(KMenuTabelView){
        
        return 5;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return self.optionResultDic.count;
    
    if (KFormTabelView) {
        
        return 1;
    }
    
    else if(KMenuTabelView){
        
        return 3;
    }
    
    return 0;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  //  if (KFormTabelView) {
        
        static NSString *cellID = @"CellId";
        
        ProductManagerCell*cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            
            cell =[[ProductManagerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        return cell;
//    }
//    
//    else {
//        
//        static NSString *cellID = @"MenuCellID";
//    
//        MenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        
//        if (!cell) {
//            
//            cell = [MenuViewCell createFromXibWithMenuViewCell];
//        }
//        
////        cell.optionA.tag = indexPath.row+2000;
////        cell.optionB.tag = indexPath.row+2001;
////        cell.optionC.tag = indexPath.row+2003;
//
//        return cell;
//    }
//    
    

}




- (IBAction)searchMenuAction:(UIButton *)sender {
    
//    _menuView = [MenuView createFromXibWithViewTag:0 ToAddView:[UIApplication sharedApplication].keyWindow];
//    _menuView.menuTabelView.delegate = self;
//    _menuView.menuTabelView.dataSource = self;
//    [_menuView show];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
    _searchMenuVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchMenuViewID"];
    [[UIApplication sharedApplication].keyWindow addSubview:_searchMenuVC.view];
    
}

@end
