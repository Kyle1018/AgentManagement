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

@implementation ProductManageViewModel

- (instancetype)init {
    
    self = [super init];
    
    if (self) {

        _productInfoDataArray = [NSMutableArray array];
        
     }
    
    return self;
}

- (RACSignal*)requestProductBrandAndPmodelData {
    
    __weak typeof(self) weakSelf = self;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.pmRequest = [[AMProductAndModelListRequest alloc]init];
        
        [self.pmRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMBaseModel *baseModel = (AMBaseModel*)model;
            
            NSArray *modelArray=[AMProductAndModel arrayOfModelsFromDictionaries:baseModel.data error:nil];

            NSMutableArray *brandArray = [NSMutableArray array];//品牌数组
            
            NSMutableArray *pmodelArray = [NSMutableArray array];//型号数组
            
            for (AMProductAndModel *model in modelArray) {
                
                [brandArray addObject:model.brand];
                
                for (NSDictionary *dic in model.pmodel) {
                    
                    NSString *pmodel = dic[@"value"];
                    
                    [pmodelArray addObject:pmodel];
                }
            
                
            }
            
            weakSelf.productAndModelArray = [NSMutableArray arrayWithObjects:brandArray,pmodelArray, nil];
            
            if (modelArray.count > 0) {
                
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

- (RACSignal*)requstProductInformationData {
    
    __weak typeof(self) weakSelf = self;
    
    RACSignal *productRelatedSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        weakSelf.priRequest = [[AMProductRelatedInformationRequest alloc] init];
        
        [weakSelf.priRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMBaseModel *baseModel = (AMBaseModel*)model;
            
            NSArray *modelArray=[AMProductRelatedInformation arrayOfModelsFromDictionaries:baseModel.data error:nil];
   
            NSMutableArray*optionTitleDataArray = [NSMutableArray arrayWithObjects:@"直接饮用",@"分类",@"过滤介质",@"产品特点",@"摆放位置",@"滤芯个数",@"适用地区",@"零售价格",@"换芯周期", nil];
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

- (RACSignal*)requestProductListDataOrSearchProductDataWithPage:(NSInteger)page Size:(NSInteger)size Search:(NSArray*)searchDic {
    
    __weak typeof(self) weakSelf = self;
    
     __block AMProductInfo *productInfoModel = nil;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)page];
        
        NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)size];
        
        weakSelf.plOrSearchRequest = [[AMProductListOrSearchRequest alloc]initWithPage:pageStr Size:sizeStr Search:searchDic];
        
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

- (NSString*)textChangeToKey:(NSString*)text {
    
    if ([text isEqualToString:@"品牌"]) {
        
        return @"brand";
    }
    else if ([text isEqualToString:@"型号"]) {
        
        return @"pmodel";
    }
    else if ([text isEqualToString:@"直接饮用"]) {
        
        return @"drinking";
    }
    else if ([text isEqualToString:@"分类"]) {
        
        return @"classification";
    }
    else if ([text isEqualToString:@"过滤介质"]) {
     
        return @"filter";
    }
    else if ([text isEqualToString:@"产品特点"]) {
        
        return @"features";
    }
    else if ([text isEqualToString:@"摆放位置"]) {
        return @"putposition";
    }
    else if ([text isEqualToString:@"滤芯个数"]) {
        return @"number";
    }
    else if ([text isEqualToString:@"适用地区"]) {
        
        return @"area";
    }
    else if ([text isEqualToString:@"零售价格"]) {
        
        return @"price";
    }
    else if ([text isEqualToString:@"换芯周期"]) {
        
        return @"cycle";
    }
    
    return nil;
}

@end
