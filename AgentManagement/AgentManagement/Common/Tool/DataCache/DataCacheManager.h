//
//  DataCacheManager.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/25.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

//插入数据库的数据类型
typedef enum FORMTYPE{
    PRODUCT_MANAGER  = 0 ,//产品管理
    CUSTIMER_MANAGER = 1,//客户管理
    COST_MANAGER     = 2 //成本管理
}FORMTYPE;

@interface DataCacheManager : NSObject

+ (DataCacheManager *)shareDataCacheManager;

- (BOOL)setInsertOrDelete:(BOOL)insert withType:(FORMTYPE)type andDic:(id)dic;

- (NSMutableArray *)getOptionResult;

- (NSUInteger)getOptionResultCount;

@end
