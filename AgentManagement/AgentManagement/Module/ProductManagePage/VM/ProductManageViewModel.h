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
#import "AMUserInformationRequest.h"
#import "AMProductListOrSearchRequest.h"
#import "AMDeleteProductRequest.h"
@interface ProductManageViewModel : NSObject

@property(nonatomic,strong)AMProductAndModelListRequest *pmRequest;//产品和型号

@property(nonatomic,strong)AMProductRelatedInformationRequest *priRequest;//产品相关信息

@property(nonatomic,strong)AMAddProductRequest *apRequset;//添加产品

@property(nonatomic,strong)AMProductListOrSearchRequest *plOrSearchRequest;//产品列表或搜索@

@property(nonatomic,strong)AMDeleteProductRequest *deleteRequest;//删除产品

//@property(nonatomic,strong)NSMutableArray *productAndModelArray;//产品和型号模型数组

//@property(nonatomic,strong)NSMutableArray *productRelatedInformationArray;//产品相关信息模型数组

@property(nonatomic,strong)NSMutableArray *productInfoDataArray;//产品列表或搜索模型数组

/**
 *  请求产品品牌和型号数据
 *
 *  @return 信号
 */
- (RACSignal*)requestProductBrandAndPmodelData;

/**
 *  可以请求产品列表数据或者请求产品搜索数据
 *
 *  @param page        第几页
 *  @param size        返回数量
 *  @param searchArray 搜索条件数据（如果不传，则返回全部列表数据）
 *
 *  @return 信号
 */
- (RACSignal*)requestProductListDataOrSearchProductDataWithPage:(NSInteger)page Size:(NSInteger)size Search:(NSDictionary*)searchDic;

/**
 *  请求产品相关参数
 *
 *  @return 信号
 */
- (RACSignal*)requstProductInformationData;


/**
 *  添加产品请求
 *
 *  @param paramt 产品模型
 *
 *  @return 信号
 */
- (RACSignal*)requstAddProductData:(NSDictionary*)paramt;

/**
 *  删除产品请求
 */
- (RACSignal*)deleteProduct:(NSDictionary*)pdInfo;


- (NSString*)textChangeToKey:(NSString*)text;

@end
