//
//  ProductManageViewModel.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "ProductManageViewModel.h"
#import "AMProductAndModel.h"
#import "AMProductRelatedInformation.h"
#import "AMProductInfo.h"

/*
 获取产品和型号列表
 data =     (
 {
 brand = c;
 pmodel =             (
 {
 value = 3;
 }
 );
 },
 {
 brand = "\U7f8e\U7684";
 pmodel =             (
 {
 value = "900\Uff0dw0x";
 },
 {
 value = "900\Uff0dw0x";
 }
 );
 },
 {
 brand = "\U4eec";
 pmodel =             (
 {
 value = "\U884c\U5417";
 },
 {
 value = "\U884c\U5417";
 }
 );
 }
 );
 resultCode = 0;
 resultMessage = ok;
 }
 
 */

/*
 获取相关信息其它配置
 <__NSArrayM 0x79144cd0>(
 {
 key = cycle;
 value =     (
 {
 value = "1\U4e2a\U6708";
 },
 {
 value = "2\U4e2a\U6708";
 },
 {
 value = "3\U4e2a\U6708";
 }
 );
 },
 {
 key = sale;
 value =     (
 {
 value = 1;
 }
 );
 },
 {
 key = admin;
 value =     (
 {
 value = 1;
 }
 );
 }
 )
 */



@implementation ProductManageViewModel

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _productRelatedInformationArray = [NSMutableArray array];
        
        _productInfoDataArray = [NSMutableArray array];
        
     }
    
    return self;
}

/**
 *  请求产品相关信息数据：名称、型号、各种产品参数
 *
 */
- (RACSignal*)requstProductInformationData {
    
    __weak typeof(self) weakSelf = self;
    
    RACSignal *productRelatedSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        weakSelf.priRequest = [[AMProductRelatedInformationRequest alloc] init];
        
        [weakSelf.priRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMBaseModel *baseModel = (AMBaseModel*)model;
            
            NSArray *modelArray=[AMProductRelatedInformation arrayOfModelsFromDictionaries:baseModel.data error:nil];
   
           for (AMProductRelatedInformation *model in modelArray) {
               
                for (int i = 0; i < model.value.count; i++) {
                    
                    NSDictionary *dic = model.value[i];
                    
                    NSString *str = dic[@"value"];
                    
                    [model.value replaceObjectAtIndex:i withObject:str];
                }
               
            }
            
            [weakSelf.productRelatedInformationArray addObjectsFromArray:modelArray];
            
            if (weakSelf.productRelatedInformationArray.count > 0) {
                
                [subscriber sendNext:@(YES)];
                [subscriber sendCompleted];
            }
            else {
                
                [subscriber sendNext:@(NO)];
                [subscriber sendCompleted];

            }
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
            [subscriber sendError:error];
        }];
        
        return nil;
    }];

    
    return productRelatedSignal;
   // return [RACSignal combineLatest:@[productNameAndPmodelSignal,productRelatedSignal]];
}

- (RACSignal*)requstAddProductData:(NSDictionary*)paramt {
    
    __weak typeof(self) weakSelf = self;
    
    __block AMProductInfo *addProductInfoModel = nil;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        
        weakSelf.apRequset = [[AMAddProductRequest alloc] initWithAddProductInfo:paramt];
        
        [weakSelf.apRequset requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            addProductInfoModel = (AMProductInfo*)model;
            NSLog(@"%@", model);
            
            [subscriber sendNext:addProductInfoModel];
            [subscriber sendCompleted];

            
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
            NSLog(@"%@", error);
            
            [subscriber sendNext:@(NO)];
            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
}


- (RACSignal*)requestProductListDataOrSearchProductDataWithPage:(NSInteger)page Size:(NSInteger)size Search:(NSArray*)searchArray {
    
    __weak typeof(self) weakSelf = self;
    
     __block AMProductInfo *productInfoModel = nil;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        NSString *pageStr = [NSString stringWithFormat:@"%ld",page];
        
        NSString *sizeStr = [NSString stringWithFormat:@"%ld",size];
        
        weakSelf.plOrSearchRequest = [[AMProductListOrSearchRequest alloc]initWithPage:pageStr Size:sizeStr Search:searchArray];
        
        [weakSelf.plOrSearchRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
             productInfoModel = (AMProductInfo*)model;
            
            NSArray *dataArray = [AMProductInfo arrayOfModelsFromDictionaries:productInfoModel.data];
            
            NSMutableArray *array = (NSMutableArray *)[[dataArray reverseObjectEnumerator] allObjects];
            
            [weakSelf.productInfoDataArray addObjectsFromArray:array];

            if (weakSelf.productInfoDataArray.count > 0) {
                
                [subscriber sendNext:@(YES)];
                [subscriber sendCompleted];
            }
            else {
                
                [subscriber sendNext:@(NO)];
                [subscriber sendCompleted];
                
            }
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
            [subscriber sendNext:@(NO)];
            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
}
@end
