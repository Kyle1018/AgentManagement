//
//  DataAnalysisViewModel.m
//  AgentManagement
//
//  Created by huabin on 16/10/14.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "DataAnalysisViewModel.h"
#import "AMProductInfo.h"
#import "AMCustomerOrSearchRequest.h"
#import "AMProductListOrSearchRequest.h"
#import "AMCustomer.h"

@interface DataAnalysisViewModel()
@property(nonatomic,copy)NSString* lastDate;
@property(nonatomic,assign)NSInteger tatol;
@property(nonatomic,strong)NSMutableArray *stock;//库存数组
@property(nonatomic,strong)NSMutableArray*lSalesVolume;//销售量数组
@property(nonatomic,strong)NSMutableArray *eSalesVolume;//销售额数组
@property(nonatomic,strong)AMProductListOrSearchRequest *plOrSearchRequest;
@property(nonatomic,strong)AMCustomerOrSearchRequest *customerOrSearchRequest;

@end
@implementation DataAnalysisViewModel
- (id)init {
    
    self = [super init];
    
    if (self) {
        
        _stock = [NSMutableArray array];
        _lSalesVolume = [NSMutableArray array];
        _eSalesVolume = [NSMutableArray array];
        
        for (int i =0; i<12; i++) {
            
            [_stock addObject:@(0)];
            [_lSalesVolume addObject:@(0)];
            [_eSalesVolume addObject:@(0)];
            
        }
    }
    
    return self;
}
//请求库存量
- (RACSignal*)requestStock {
    
   __block NSMutableArray*productInfoArray = [NSMutableArray array];
    __block NSMutableDictionary*dataDic = [NSMutableDictionary dictionary];
    
    RACSignal*stockSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.plOrSearchRequest = [[AMProductListOrSearchRequest alloc]initWithPage:0 Size:0 Search:nil];
        
        [self.plOrSearchRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMProductInfo*productInfoModel = (AMProductInfo*)model;
            
           // NSArray *dataArray = [AMProductInfo arrayOfModelsFromDictionaries:productInfoModel.data];
            
           // NSMutableArray *array = (NSMutableArray *)[[dataArray reverseObjectEnumerator] allObjects];
            
           // productInfoArray = array;

            NSMutableArray *dataArray01 = [NSMutableArray array];
            
            NSMutableDictionary *listDataDic = [NSMutableDictionary dictionary];
            
            /*
            for (AMProductInfo *productInfo in array) {
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM"];
                
                NSString *currentDateStr = [NSString timeTransformString:productInfo.add_time dateFormatter:dateFormatter];
                
                NSInteger year = [[currentDateStr substringToIndex:4]integerValue];
                
                NSString *month = [currentDateStr substringFromIndex:5];
                
                if ([[month substringToIndex:1]isEqualToString:@"0"]) {
                    
                    month = [month substringFromIndex:1];
                    
                }
                //获取当前年份
                NSDate *now = [NSDate date];
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
                NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
                NSInteger nowYear = [dateComponent year];
                
                if (year==nowYear) {
                    
                    if ([currentDateStr isEqualToString:self.lastDate]) {
                        
                        [dataArray01 addObject:productInfo];
                        
                        [listDataDic safeSetObject:dataArray01 forKey:month];
                    }
                    
                    else {
                        
                        NSMutableArray *dd = [NSMutableArray array];
                        
                        [dd addObject:productInfo];
                        
                        [listDataDic safeSetObject:dd forKey:month];
                        
                        dataArray01 =dd;
                    }
                    
                    self.lastDate = currentDateStr;
                    
                }
            }
            */
        
            [listDataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
               
                for (AMProductInfo*info in obj) {
                    
                    _tatol += [info.stock_number integerValue];
                }
                
                [_stock replaceObjectAtIndex:[key integerValue]-1 withObject:@(_tatol)];
                _tatol = 0;
                
            }];
            
            [subscriber sendNext:_stock];
            [subscriber sendCompleted];
 
        } failure:^(KKBaseModel *model, KKRequestError *error) {
         
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
    RACSignal *lSalesVolumeSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        self.customerOrSearchRequest = [[AMCustomerOrSearchRequest alloc]initWithPage:0 Size:0 Search:nil];
        
        [self.customerOrSearchRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMBaseModel *baseModel = (AMBaseModel*)model;
            
            NSMutableDictionary*listDataDic = [NSMutableDictionary dictionary];
            
            /*
            for (NSDictionary*dic in baseModel.data) {
                
                NSArray *array = dic[@"order"];
                
                for (NSDictionary *dicc in array) {
                    
                    NSDictionary *brandAndPmodel = [NSDictionary dictionaryWithObjectsAndKeys:dicc[@"brand"],@"brand",dicc[@"pmodel"],@"pmodel", nil];
                    
                    NSInteger year = [[dicc[@"buy_time"] substringToIndex:4]integerValue];
                    
                    NSString *month = [dicc[@"buy_time"] substringWithRange:NSMakeRange(5, 2)];
                    
                    if ([[month substringToIndex:1]isEqualToString:@"0"]) {
                        
                        month = [month substringFromIndex:1];
                        
                    }
                    
                    NSDate *now = [NSDate date];
                    NSCalendar *calendar = [NSCalendar currentCalendar];
                    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
                    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
                    NSInteger nowYear = [dateComponent year];
                    
                    
                    if (year==nowYear) {
                        
                        if ([listDataDic objectForKey:month]) {
                            
                            NSMutableArray *array = [listDataDic objectForKey:month];
                            
                            [array addObject:brandAndPmodel];
                            
                            [listDataDic safeSetObject:array forKey:month];
                            
                            
                        }
                        else {
                            
                            
                            
                            NSMutableArray *yy = [NSMutableArray arrayWithObject:brandAndPmodel];
                            
                            [listDataDic safeSetObject:yy forKey:month];
                        }
                        
                    }
                }
            }
            */
            dataDic = listDataDic;
            
            [listDataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                
                [_lSalesVolume replaceObjectAtIndex:[key integerValue]-1 withObject:@( [obj count])];
                
            }];
   
            [subscriber sendNext:_lSalesVolume];
            [subscriber sendCompleted];
            
            
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];

    RACSignal *eSalesVolume = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       

        [dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            NSArray *value = obj;
            
            for (NSDictionary*dic in value) {
                
                for (AMProductInfo*info in productInfoArray) {
                    
                    if ([dic[@"brand"]isEqualToString:info.brand]&&[dic[@"pmodel"]isEqualToString:info.pmodel]) {
                        
                        _tatol+=[info.price integerValue];
                    }
                }
            }
            
            [_eSalesVolume replaceObjectAtIndex:[key integerValue]-1 withObject:@(_tatol)];
            _tatol = 0;
        }];
        
        [subscriber sendNext:_eSalesVolume];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
    RACSignal*d= [RACSignal combineLatest:@[stockSignal,lSalesVolumeSignal]];
    
    return [RACSignal concat:@[d,eSalesVolume]];
 
 
    
}

/*
//请求销售量
- (RACSignal*)requestLSalesVolume {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.customerOrSearchRequest = [[AMCustomerOrSearchRequest alloc]initWithPage:0 Size:0 Search:nil];
        
        [self.customerOrSearchRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMBaseModel *baseModel = (AMBaseModel*)model;

            NSMutableDictionary*listDataDic = [NSMutableDictionary dictionary];
            
            for (NSDictionary*dic in baseModel.data) {
                
                NSArray *array = dic[@"order"];
                
                for (NSDictionary *dicc in array) {
                    
                    NSDictionary *brandAndPmodel = [NSDictionary dictionaryWithObjectsAndKeys:dicc[@"brand"],@"brand",dicc[@"pmodel"],@"pmodel", nil];
   
                    NSInteger year = [[dicc[@"buy_time"] substringToIndex:4]integerValue];
                    
                    NSString *month = [dicc[@"buy_time"] substringWithRange:NSMakeRange(5, 2)];
                    
                    if ([[month substringToIndex:1]isEqualToString:@"0"]) {
                        
                        month = [month substringFromIndex:1];
                        
                    }
                    
                    NSDate *now = [NSDate date];
                    NSCalendar *calendar = [NSCalendar currentCalendar];
                    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
                    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
                    NSInteger nowYear = [dateComponent year];
                    
                    
                    if (year==nowYear) {
                        
                        if ([listDataDic objectForKey:month]) {
                            
                            NSMutableArray *array = [listDataDic objectForKey:month];
                            
                            [array addObject:brandAndPmodel];
                            
                            [listDataDic safeSetObject:array forKey:month];
                            
                            
                        }
                        else {
                            
                            
                            
                             NSMutableArray *yy = [NSMutableArray arrayWithObject:brandAndPmodel];
  
                             [listDataDic safeSetObject:yy forKey:month];
                        }
                        
                    }
                }
            }
            
            [listDataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                

                [_lSalesVolume replaceObjectAtIndex:[key integerValue]-1 withObject:@( [obj count])];

            }];
            
            [subscriber sendNext:_lSalesVolume];
            [subscriber sendCompleted];

            
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
          
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
*/
@end
