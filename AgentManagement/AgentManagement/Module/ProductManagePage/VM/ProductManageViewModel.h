//
//  ProductManageViewModel.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMProductAndModelListRequest.h"
#import "AMProductRelatedInformationRequest.h"
#import "AMAddProductRequest.h"
@interface ProductManageViewModel : NSObject

@property(nonatomic,strong)AMProductAndModelListRequest *pmRequest;//产品和型号

@property(nonatomic,strong)AMProductRelatedInformationRequest *priRequest;//产品相关信息

@property(nonatomic,strong)AMAddProductRequest *apRequset;//添加产品

@property(nonatomic,strong)NSMutableArray *productRelatedInformationArray;

- (RACSignal*)requestProductAndModelListData;//请求产品和型号列表请求

- (RACSignal*)requestProductRelatedInformationData;//请求产品相关信息请求

- (RACSignal*)requstAddProductData:(NSDictionary*)paramt;//添加产品请求

@end
