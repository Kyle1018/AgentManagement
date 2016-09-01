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

@property(nonatomic,strong)NSMutableArray *productAndModelArray;//产品和型号模型数组

@property(nonatomic,strong)NSMutableArray *productRelatedInformationArray;//产品相关信息模型数组

- (RACSignal*)requstProductInformationData;

- (RACSignal*)requstAddProductData:(NSDictionary*)paramt;//添加产品请求

@end
