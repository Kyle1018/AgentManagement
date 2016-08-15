//
//  ProductManageViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "ProductManageViewController.h"
//#import "FormTabelView.h"
//#import "FormTabelViewProtocol.h"
#import "ProductManagerCell.h"
#import "UIView+KKFrame.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
@interface ProductManageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dd;



@end

@implementation ProductManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     self.dd.delegate = self;
     self.dd.dataSource = self;
    
//    self.dd.separatorInset = UIEdgeInsetsMake(0, -100, 0, 0);
    
 //   self.lineA.sd_layout.widthIs(10);
//    self.lineA.frame = CGRectMake(88, 0, 10, 41);
//
    

    //[self.view addSubview: self.dd];

    
//    UIView *headerView = self.formTabelView.tableHeaderView;
//    headerView.frame = CGRectMake(-50, 0, self.view.bounds.size.width, 100);
//    self.formTabelView.tableHeaderView = headerView;
    
  
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
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
