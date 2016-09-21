//
//  CustomerManageViewModel.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/11.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CustomerManageViewModel.h"
#import "AMProductAndModel.h"
#import "AMAdministrators.h"
#import "AMSales.h"
#import "AMCustomer.h"
#import "AMOrder.h"
@implementation CustomerManageViewModel

- (id)init {
    
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (RACSignal*)requestAreaListData:(NSInteger)index lIndex:(NSInteger)lIndex {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
 
        NSString* plistPath=[[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
        NSDictionary*plistDic=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
        NSArray *areaArray = [NSArray arrayWithArray:plistDic[@"address"]];
        
        NSMutableArray*province = [NSMutableArray array];//省
        
        for (NSDictionary*dic in areaArray) {
            
            NSString *name = dic[@"name"];
            
            [province addObject:name];
            
        }
        
        NSDictionary *dicc =areaArray[index];//根据下标取出省份字典
        
        NSArray *a1=dicc[@"sub"];
        
        NSMutableArray*city = [NSMutableArray array ];//市
        
        NSMutableArray *district = [NSMutableArray array];//区县
        
        for (NSDictionary*diccc in a1) {
            
            [city addObject:diccc[@"name"]];
        }
        
        NSDictionary *dict = a1[lIndex];
            
        [district addObjectsFromArray:dict[@"sub"]];

        NSDictionary *areaDic = [NSDictionary dictionaryWithObjectsAndKeys:province,@"province",city,@"city",district,@"district", nil];

        [subscriber sendNext:areaDic];
        [subscriber sendCompleted];
        
        return nil;
    }];
}

- (RACSignal*)requestCustomerInfoListDataOrSearchCustomerInfoDataWithPage:(NSInteger)page size:(NSInteger)size search:(NSDictionary*)searchDic {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.customerOrSearchRequest = [[AMCustomerOrSearchRequest alloc]initWithPage:page Size:size Search:searchDic];
        
        [self.customerOrSearchRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMBaseModel *baseModel = (AMBaseModel*)model;
            
            NSMutableArray *customerArray = [NSMutableArray array];
            
            for (NSDictionary *dic in baseModel.data) {
                
                NSArray *array = dic[@"order"];
                
                NSMutableArray *orderArray = [NSMutableArray array];
                
                for (NSDictionary *dicc in array) {
                    
                    AMOrder *order = [[AMOrder alloc]initWithDictionary:dicc error:nil];
                    
                    [orderArray addObject:order];
                }
                
                AMCustomer *customerModel = [[AMCustomer alloc]initWithDictionary:dic error:nil];
                
                customerModel.orderArray = orderArray;
                
                [customerArray addObject:customerModel];
                
            }
            self.customerModelArray = customerArray;
            
            if (self.customerModelArray.count > 0) {
                
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

//添加客户请求
- (RACSignal*)requstAddCustomerData:(NSDictionary*)paramt {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        self.addCustomerRequest = [[AMAddCustomerRequest alloc]initWithAddCustomerInfo:paramt];
        
        [self.addCustomerRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            NSLog(@"%@",model);
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
        }];
        
        return nil;
    }];
}

//请求销售员列表
- (RACSignal*)requstSalersList {
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.request1 = [[AMSalerListOrSearchRequest alloc]initWithPage:@"0" Size:@"0" Search:nil];
    
        [self.request1 requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            if ([model isValid]) {
                
                AMBaseModel *baseModel = (AMBaseModel*)model;
                
                NSMutableArray *salersNameArray = [NSMutableArray array];
                
                for (NSDictionary*dic in baseModel.data) {
                    
                    AMSales *model = [[AMSales alloc]initWithDictionary:dic error:nil];
                    
                    [salersNameArray addObject:model];
                }
                
                [subscriber sendNext:salersNameArray];
                [subscriber sendCompleted];
            }
            else {
                
                [subscriber sendError:error];
            }
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [self.request1 cancel];
        }];
    }];
    
    return [signal takeUntil:self.rac_willDeallocSignal];
}

//请求管理员列表
- (RACSignal*)requestAdministratorList {
    
     RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
         self.request2 = [[AMAdministratorListOrSearchRequest alloc]initWithPage:@"0" Size:@"0" Search:nil];
         
         [ self.request2 requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
             
             if ([model isValid]) {
                 
                 AMBaseModel *baseModel = (AMBaseModel*)model;
                 
                 NSMutableArray *nameArray = [NSMutableArray array];
                 
                 for (NSDictionary*dic in baseModel.data) {
                     
                     AMAdministrators *model = [[AMAdministrators alloc]initWithDictionary:dic error:nil];
                     
                     [nameArray addObject:model];
                 }
                 
                 [subscriber sendNext:nameArray];
                 [subscriber sendCompleted];
             }
             else {
                 
                 [subscriber sendError:error];
             }
             
             NSLog(@"%@",model);
             
             
         } failure:^(KKBaseModel *model, KKRequestError *error) {
             
              [subscriber sendError:error];
         }];
         
        return [RACDisposable disposableWithBlock:^{
            
            [self.request2 cancel];
        }];
    }];
    
    return [signal takeUntil:self.rac_willDeallocSignal];
}


@end
