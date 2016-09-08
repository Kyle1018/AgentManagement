//
//  ProductDetailViewController.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "BaseTableViewController.h"
#import "AMProductInfo.h"

typedef void(^TapDeleteProductBlock)();

@interface ProductDetailViewController : BaseTableViewController

@property(nonatomic,strong)AMProductInfo *productInfo;

@property(nonatomic,strong)NSArray *productRelatedInformationArray;

@property(nonatomic,copy)TapDeleteProductBlock tapDeleteProductBlock;

@end
