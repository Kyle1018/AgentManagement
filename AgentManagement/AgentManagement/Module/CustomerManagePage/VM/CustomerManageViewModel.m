//
//  CustomerManageViewModel.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/11.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CustomerManageViewModel.h"

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

@end
