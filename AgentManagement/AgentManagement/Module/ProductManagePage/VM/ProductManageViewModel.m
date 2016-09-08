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
   
//           for (AMProductRelatedInformation *model in modelArray) {
//               
//      
//               
//            }
            
//
           
            NSMutableArray*optionTitleDataArray = [NSMutableArray arrayWithObjects:@"直接饮用",@"分类",@"过滤介质",@"产品特点",@"摆放位置",@"滤芯个数",@"使用地区",@"零售价格",@"换芯周期", nil];
            NSMutableArray*optionDataArray = [NSMutableArray arrayWithObjects:
                                @[@"可以",@"不可以"],
                                @[@"纯水机",@"家用净水机",@"商用净水器",@"软水机",@"管线机",@"水处理设备",@"龙头净水器",@"净水杯"],
                                @[@"反渗透",@"超滤",@"活性炭",@"PP棉",@"陶瓷纳滤",@"不锈钢滤网",@"微滤",@"其它"],
                                @[@"无废水",@"无桶大通量",@"双出水",@"滤芯寿命提示",@"低废水单出水",@"双模双出水",@"紫外线杀菌",@"TDS显示"],
                                @[@"厨下式",@"龙头式",@"台上式",@"滤芯寿命提示",@"低废水入户过滤",@"壁挂式",@"其它"],
                                @[@"1级",@"2级",@"3级",@"4级",@"5级",@"6级",@"6级以上"],
                                @[@"华北",@"华南",@"华东",@"华中",@"其它"],
                                @[@"手动输入价格"],
                                @[@"1个月",@"3个月",@"6个月",@"12个月",@"18个月",@"24个月"],nil];
            
            weakSelf.productRelatedInformationArray = [NSMutableArray arrayWithObject:optionTitleDataArray];
            for (AMProductRelatedInformation *model in modelArray) {
                
                for (int i = 0; i < model.value.count; i++) {
                    
                    NSDictionary *dic = model.value[i];
                    
                    NSString *str = dic[@"value"];
                    
                    [model.value replaceObjectAtIndex:i withObject:str];
                }
                
                if ([model.key isEqualToString:@"drinking"]) {
                    
                    [optionDataArray replaceObjectAtIndex:0 withObject:model.value];
                }
                
                else if ([model.key isEqualToString:@"classification"]) {
                    
                    [optionDataArray replaceObjectAtIndex:1 withObject:model.value];
                }
                else if ([model.key isEqualToString:@"filter"]) {
                    
                    [optionDataArray replaceObjectAtIndex:2 withObject:model.value];
                }
                else if ([model.key isEqualToString:@"features"]) {
                    
                    [optionDataArray replaceObjectAtIndex:3 withObject:model.value];
                }
                else if ([model.key isEqualToString:@"putposition"]) {
                    
                    [optionDataArray replaceObjectAtIndex:4 withObject:model.value];
                }
                else if ([model.key isEqualToString:@"number"]) {
                    
                    [optionDataArray replaceObjectAtIndex:5 withObject:model.value];
                }
                else if ([model.key isEqualToString:@"area"]) {
                    
                    [optionDataArray replaceObjectAtIndex:6 withObject:model.value];
                }
                
                else if ([model.key isEqualToString:@"cycle"]) {
                    
                    [optionDataArray replaceObjectAtIndex:8 withObject:model.value];
                }
                
          
            }
            
            [weakSelf.productRelatedInformationArray addObject:optionDataArray];
            
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
            if (addProductInfoModel.resultCode == 0) {
                
                [subscriber sendNext:addProductInfoModel];
                [subscriber sendCompleted];
            }
            
            else {
                
                [subscriber sendNext:@(NO)];
                [subscriber sendCompleted];
            }
            

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
       
        NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)page];
        
        NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)size];
        
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

- (RACSignal*)deleteProduct:(NSDictionary*)pdInfo; {
    
    __weak typeof(self) weakSelf = self;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      
        weakSelf.deleteRequest = [[AMDeleteProductRequest alloc]initWithPD_id:pdInfo];
        
        [weakSelf.deleteRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            [subscriber sendNext:@(YES)];
            [subscriber sendCompleted];
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            [subscriber sendNext:@(NO)];
            [subscriber sendCompleted];
          
        }];
        
        return nil;
    }];
}
@end
