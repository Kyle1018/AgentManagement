//
//  DataAnalysisViewModel.m
//  AgentManagement
//
//  Created by huabin on 16/10/14.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "DataAnalysisViewModel.h"
#import "AMProductInfo.h"
@interface DataAnalysisViewModel()
@property(nonatomic,copy)NSString* lastDate;
@property(nonatomic,assign)NSInteger kucunTatol;
@property(nonatomic,strong)NSMutableArray *stock;//库存数组
@property(nonatomic,strong)NSMutableArray*lSalesVolume;//销售量数组
@property(nonatomic,strong)NSMutableArray *eSalesVolume;//销售额数组
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
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.plOrSearchRequest = [[AMProductListOrSearchRequest alloc]initWithPage:0 Size:0 Search:nil];
        
        [self.plOrSearchRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMProductInfo*productInfoModel = (AMProductInfo*)model;
            
            NSArray *dataArray = [AMProductInfo arrayOfModelsFromDictionaries:productInfoModel.data];
            
            NSMutableArray *array = (NSMutableArray *)[[dataArray reverseObjectEnumerator] allObjects];

            NSMutableArray *dataArray01 = [NSMutableArray array];
            
            NSMutableDictionary *listDataDic = [NSMutableDictionary dictionary];
            
            for (AMProductInfo *productInfo in array) {
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM"];
                
                NSString *currentDateStr = [NSString timeTransformString:productInfo.add_time dateFormatter:dateFormatter];
                
                NSInteger year = [[currentDateStr substringToIndex:4]integerValue];
                
                NSString *month = [currentDateStr substringFromIndex:5];
                
                if ([[month substringToIndex:1]isEqualToString:@"0"]) {
                    
                    month = [month substringFromIndex:1];
                    
                }
                NSLog(@"%@",month);
                
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
            
        
            [listDataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
               
                for (AMProductInfo*info in obj) {
                    
                    _kucunTatol += [info.stock_number integerValue];
                }
                
                [_stock replaceObjectAtIndex:[key integerValue]-1 withObject:@(_kucunTatol)];
                _kucunTatol = 0;
                
            }];
            
            [subscriber sendNext:_stock];
            [subscriber sendCompleted];
 
        } failure:^(KKBaseModel *model, KKRequestError *error) {
         
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

//请求销售量
- (RACSignal*)requestLSalesVolume {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

@end
