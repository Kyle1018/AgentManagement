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

- (RACSignal*)requestProductBrandAndPmodelData {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.pmRequest = [[AMProductAndModelListRequest alloc]init];
        
        [self.pmRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMBaseModel *baseModel = (AMBaseModel*)model;
            /*
             <__NSArrayM 0x7f9daa4bbcb0>(
             {
             brand = "\U7d22\U5c3c";
             pmodel =     (
             {
             value = sss;
             }
             );
             }
             )
             */
            NSArray *modelArray=[AMProductAndModel arrayOfModelsFromDictionaries:baseModel.data error:nil];

            NSMutableArray *brandArray = [NSMutableArray array];//品牌数组
            
            NSMutableArray *pmodelArray = [NSMutableArray array];//型号数组
            
            NSMutableArray*CpmodelArray = [NSMutableArray array];//用于添加用户时，购买机型选项
            
            for (AMProductAndModel *model in modelArray) {
                
                [brandArray addObject:model.brand];
                
                NSMutableArray *array = [NSMutableArray array];
                
                for (NSDictionary *dic in model.pmodel) {
                    
                    NSString *pmodel = dic[@"value"];
                    
                    [pmodelArray addObject:pmodel];
                    [array addObject:pmodel];
                }
                
                [CpmodelArray addObject:array];
            
                
            }
            
      
             NSMutableArray *productAndModelArray = [NSMutableArray arrayWithObjects:brandArray,pmodelArray,CpmodelArray, nil];

            if (brandArray.count > 0 && pmodelArray.count>0) {
                
                [subscriber sendNext:productAndModelArray];
                
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
    
    RACSignal *productRelatedSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        self.priRequest = [[AMProductRelatedInformationRequest alloc] init];
        
        [self.priRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMBaseModel *baseModel = (AMBaseModel*)model;
      
            NSArray *modelArray=[AMProductRelatedInformation arrayOfModelsFromDictionaries:baseModel.data error:nil];
   
            NSMutableArray*optionTitleDataArray = [NSMutableArray arrayWithObjects:@"品牌",@"型号",@"直接饮用",@"分类",@"过滤介质",@"产品特点",@"摆放位置",@"滤芯个数",@"适用地区",@"零售价格",@"换芯周期", nil];
            NSMutableArray*optionDataArray = [NSMutableArray arrayWithObjects:
                                @[@"美的",@"格力",@"飞利浦",@"LG",@"索尼",@"夏普"],//品牌
                                @[@"CJ100",@"HB200",@"KK304",@"LE909",@"PP208"],//型号
                                @[@"可以",@"不可以"],//直接饮用
                                @[@"纯水机",@"家用净水机",@"商用净水器",@"软水机",@"管线机",@"水处理设备",@"龙头净水器",@"净水杯"],//分类
                                @[@"反渗透",@"超滤",@"活性炭",@"PP棉",@"陶瓷纳滤",@"不锈钢滤网",@"微滤",@"其它"],//过滤介质
                                @[@"无废水",@"无桶大通量",@"双出水",@"滤芯寿命提示",@"低废水单出水",@"双模双出水",@"紫外线杀菌",@"TDS显示"],//产品特点
                                @[@"厨下式",@"龙头式",@"台上式",@"滤芯寿命提示",@"低废水入户过滤",@"壁挂式",@"其它"],//摆放位置
                                @[@"1级",@"2级",@"3级",@"4级",@"5级",@"6级",@"6级以上"],//滤芯个数
                                @[@"华北",@"华南",@"华东",@"华中",@"其它"],//适用地区
                                @[@"手动输入价格"],
                                @[@"1个月",@"3个月",@"6个月",@"12个月",@"18个月",@"24个月"],nil];//换芯周期
            
            for (AMProductRelatedInformation *model in modelArray) {
                
                for (int i = 0; i < model.value.count; i++) {
                    
                    NSDictionary *dic = model.value[i];
                    
                    NSString *str = dic[@"value"];
                    
                    [model.value replaceObjectAtIndex:i withObject:str];
                }
                
                if ([model.key isEqualToString:@"brand"]) {
                    
                    [optionDataArray replaceObjectAtIndex:0 withObject:model.value];
                }
                else if ([model.key isEqualToString:@"pmodel"]){
                    
                    [optionDataArray replaceObjectAtIndex:1 withObject:model.value];
                }
                
                else if ([model.key isEqualToString:@"drinking"]) {
                    
                    [optionDataArray replaceObjectAtIndex:2 withObject:model.value];
                }

                else if ([model.key isEqualToString:@"classification"]) {
                    
                    [optionDataArray replaceObjectAtIndex:3 withObject:model.value];
                }
                else if ([model.key isEqualToString:@"filter"]) {
                    
                    [optionDataArray replaceObjectAtIndex:4 withObject:model.value];
                }
                else if ([model.key isEqualToString:@"features"]) {
                    
                    [optionDataArray replaceObjectAtIndex:5 withObject:model.value];
                }
                else if ([model.key isEqualToString:@"putposition"]) {
                    
                    [optionDataArray replaceObjectAtIndex:6 withObject:model.value];
                }
                else if ([model.key isEqualToString:@"number"]) {
                    
                    [optionDataArray replaceObjectAtIndex:7 withObject:model.value];
                }
                else if ([model.key isEqualToString:@"area"]) {
                    
                    [optionDataArray replaceObjectAtIndex:8 withObject:model.value];
                }
                else if ([model.key isEqualToString:@"cycle"]) {
                    
                    [optionDataArray replaceObjectAtIndex:10 withObject:model.value];
                }
                
            }
            
            
           NSMutableArray*productRelatedInformationArray = [NSMutableArray arrayWithObjects:optionTitleDataArray,optionDataArray, nil];
            
            if (optionTitleDataArray.count>0 && optionDataArray.count>0) {
                
                [subscriber sendNext:productRelatedInformationArray];
                
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

    return productRelatedSignal;
}

- (RACSignal*)requstAddProductData:(NSDictionary*)paramt {
    
    
   // __block AMProductInfo *addProductInfoModel = nil;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        
        self.apRequset = [[AMAddProductRequest alloc] initWithAddProductInfo:paramt];
        
        [self.apRequset requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMProductInfo*addProductInfoModel = (AMProductInfo*)model;
            DDLogDebug(@"%@", model);
            if ([addProductInfoModel.resultCode integerValue]== 0) {
                
                [subscriber sendNext:addProductInfoModel];
                [subscriber sendCompleted];
            }
            
            else {
                
                [subscriber sendNext:@(NO)];
                [subscriber sendCompleted];
            }
            

        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
            DDLogDebug(@"%@", error);
            
            [subscriber sendNext:@(NO)];
            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
}

- (RACSignal*)requestProductListDataOrSearchProductDataWithPage:(NSInteger)page Size:(NSInteger)size Search:(NSArray*)searchDic {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)page];
        
        NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)size];
        
        self.plOrSearchRequest = [[AMProductListOrSearchRequest alloc]initWithPage:pageStr Size:sizeStr Search:searchDic];
        
        [self.plOrSearchRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
             AMProductInfo*productInfoModel = (AMProductInfo*)model;
            
            NSArray *dataArray = [AMProductInfo arrayOfModelsFromDictionaries:productInfoModel.data];
            
            NSMutableArray *array = (NSMutableArray *)[[dataArray reverseObjectEnumerator] allObjects];
            
            self.productInfoDataArray =[NSMutableArray arrayWithArray:array];

            if (self.productInfoDataArray.count > 0) {
                
                [subscriber sendNext:@(1)];
                [subscriber sendCompleted];
            }
            else {
                
                [subscriber sendNext:@(2)];
                [subscriber sendCompleted];
                
            }
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
            [subscriber sendNext:@(3)];
            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
}

- (RACSignal*)deleteProduct:(NSDictionary*)pdInfo; {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      
        self.deleteRequest = [[AMDeleteProductRequest alloc]initWithPD_id:pdInfo];
        
        [self.deleteRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            [subscriber sendNext:@(YES)];
            [subscriber sendCompleted];
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
           
            [subscriber sendNext:@(NO)];
            [subscriber sendCompleted];
          
        }];
        
        return nil;
    }];
}

- (RACSignal*)editProduct:(NSDictionary*)pdInfo {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        self.editProductRequest = [[AMEditProductRequest alloc]initWithEditProductInfo:pdInfo];
        
        [self.editProductRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
       
            [subscriber sendNext:model];
            [subscriber sendCompleted];
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
            [subscriber sendError:error];
            
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
