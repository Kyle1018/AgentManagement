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
/*
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
        
        //_productRelatedInformationArray = [NSMutableArray array];
    }
    
    return self;
}
- (RACSignal*)requestProductAndModelListData {
    
    __weak typeof(self) weakSelf = self;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        weakSelf.pmRequest = [[AMProductAndModelListRequest alloc] init];
        
        [weakSelf.pmRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            NSLog(@"%@", model);
            
            
            AMProductAndModel *productAndModel = (AMProductAndModel*)model;
            
            
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            NSLog(@"%@", model);
            
            [subscriber sendNext:@(NO)];
        }];
        
        return nil;
    }];
}


- (RACSignal*)requestProductRelatedInformationData {
    
    __weak typeof(self) weakSelf = self;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        
        weakSelf.priRequest = [[AMProductRelatedInformationRequest alloc] init];
        
        [weakSelf.priRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {

            AMBaseModel *baseModel = (AMBaseModel*)model;
            
            NSArray *modelArray=[AMProductRelatedInformation arrayOfModelsFromDictionaries:baseModel.data error:nil];
  
            
            weakSelf.productRelatedInformationArray  = [NSMutableArray arrayWithArray:modelArray];
           // [_productRelatedInformationArray addObjectsFromArray:modelArray];

            if (weakSelf.productRelatedInformationArray.count > 0) {
                
                [subscriber sendNext:@(RequestSuccess)];
            }
            else {
                
                [subscriber sendNext:@(RequestNoData)];
            }
     
        } failure:^(KKBaseModel *model, KKRequestError *error) {
         
            
            [subscriber sendNext:@(RequestError)];
        }];
        
        return nil;
    }];

    
}


@end
