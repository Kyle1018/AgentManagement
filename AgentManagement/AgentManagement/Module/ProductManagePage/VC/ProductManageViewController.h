//
//  ProductManageViewController.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "BaseViewController.h"
#import "AMProductInfo.h"

@interface ProductManageViewController : BaseViewController

@property(nonatomic,strong)AMProductInfo *productInfo;

@property(nonatomic,strong)NSMutableDictionary *optionDic;

@end


/*
 1.产品管理列表中的查看详情，进入查看详情页面，当点击编辑产品选项后，进行产品编辑，编辑完之后保存如何处理？
 
 2.删除产品时，没有任何返回信息，
 
 3.成本管理页面中，成本管理详情中的备注如何存储
 
 */