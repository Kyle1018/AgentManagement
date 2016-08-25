//
//  DataCacheManager.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/25.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "DataCacheManager.h"
#import "FMDB.h"

@interface DataCacheManager()
{
    FMDatabase *_db;
}

@end

@implementation DataCacheManager

+ (DataCacheManager *)shareDataCacheManager; {
    
    static DataCacheManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareInstance=[[DataCacheManager alloc] init];
    });
    return shareInstance;
}

- (BOOL)setInsertOrDelete:(BOOL)insert withType:(FORMTYPE)type andDic:(id)dic {
    
    if (insert) {
        return [self insertOptionResult:type andDic:dic];
    }else{
        return [self deleteOptionResult:type addDic:dic];
    }
}


- (BOOL)openDatabase
{
    //先判断数据库是否存在，如果不存在，创建数据库
    if (!_db)
    {
        [self creatDatabase];
    }
    
    BOOL isOpenSuccess = [_db open];
    
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (!isOpenSuccess)
    {
        NSLog(@"数据库打开失败");
    }
    
    return isOpenSuccess;
}

- (void)creatDatabase
{
    _db = [[FMDatabase alloc] initWithPath:[self databaseFilePath]];
    
}

- (NSString *)databaseFilePath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [filePath objectAtIndex:0];
    NSLog(@"%@",filePath);
    NSString *dbFilePath = [cachePath stringByAppendingPathComponent:@"optionResult.sqlite"];
    return dbFilePath;
}

- (BOOL)closeDatabase
{
    [_db closeOpenResultSets];
    
    BOOL isCloseSuccess = [_db close];
    
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (!isCloseSuccess)
    {
        NSLog(@"数据库关闭失败");
    }
    
    return isCloseSuccess;
}

- (BOOL)creatOptionTable
{
    //判断数据库中是否已经存在这个表，如果不存在则创建该表
    if(![_db tableExists:@"optionResult"])
    {
        BOOL creatSuccess = [_db executeUpdate:@"CREATE TABLE optionResult(model text,brand text, isDrinking text, classification text, filterMedia text, productFeatures text, placingPosition text, filterElementCounts text, applyRegion text, wholesalePrice text, changeFilterElementCycle text, purchasePrice text, purchaseCount text)"];
        
        if(!creatSuccess)
        {
            NSLog(@"创建攻略表完成");
        }
        return creatSuccess;
    }
    
    //已存在此表
    return YES;
}

- (BOOL)insertOptionResult:(FORMTYPE)type andDic:(id)dic
{
    //插入的数据为空，直接返回失败
    if (!dic) {
        return NO;
    }
    //打开数据库，如果没有打开，直接返回
    if (![self openDatabase]) {
        return NO;
    }
    //无表则先创建表
    if(![_db tableExists:@"optionResult"])
    {
        if(![self creatOptionTable])
            return NO;
    }
    
    
    BOOL isExecuteSuccess = NO;
    
    NSString *model = [dic objectForKey:@"model"];//型号
    
    NSString *brand = [dic objectForKey:@"brand"];//品牌
    
    NSString *isDrinking = [dic objectForKey:@"isDrinking"];//是否能直接饮用
    
    NSString *classification = [dic objectForKey:@"classification"];//分类
    
    NSString *filterMedia = [dic objectForKey:@"filterMedia"];//过滤介质
    
    NSString *productFeatures = [dic objectForKey:@"productFeatures"];//产品特点
    
     NSString *placingPosition = [dic objectForKey:@"placingPosition"];//摆放位置
    
     NSString *filterElementCounts = [dic objectForKey:@"filterElementCounts"];//滤芯个数
    
    NSString *applyRegion = [dic objectForKey:@"applyRegion"];//适用地区
    
    NSString *wholesalePrice = [dic objectForKey:@"wholesalePrice"];//零售价格
    
      NSString *changeFilterElementCycle = [dic objectForKey:@"changeFilterElementCycle"];//换滤芯周期
    
    NSString *purchasePrice = [dic objectForKey:@"purchasePrice"];//进货价格
    
       NSString *purchaseCount = [dic objectForKey:@"purchaseCount"];//进货数量
    
        isExecuteSuccess = [_db executeUpdate:@"INSERT INTO optionResult (model , brand , isDrinking , classification , filterMedia , productFeatures,placingPosition,filterElementCounts,applyRegion,wholesalePrice,changeFilterElementCycle,purchasePrice,purchaseCount) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",model,brand,isDrinking,classification,filterMedia,productFeatures,placingPosition,filterElementCounts,applyRegion,wholesalePrice,changeFilterElementCycle,purchasePrice,purchaseCount];

    
    [self closeDatabase];
    
    return isExecuteSuccess;
}

- (BOOL)deleteOptionResult:(FORMTYPE)type addDic:(id)dic
{
    //插入的数据为空，直接返回失败
    if(!dic)
        return NO;
    
    //打开数据库，如果没有打开，直接返回
    if(![self openDatabase])
        return NO;
    
    if(![_db tableExists:@"optionResult"])
    {
        return NO;
    }
    
    BOOL deleteSuccess = NO;
    
     deleteSuccess = [_db executeUpdate:@"delete from optionResult where model = ?", [dic objectForKey:@"model"]];
    
    [self closeDatabase];

    return deleteSuccess;
}

- (NSMutableArray *)getOptionResult
{
    //打开数据库，如果没有打开，直接返回
    if(![self openDatabase])
        return nil;
    
    if(![_db tableExists:@"optionResult"])
    {
        return nil;
    }
    
    //定义一个可变数组，用来存放查询的结果，返回给调用者
    NSMutableArray *dataArray = [NSMutableArray array];

    //定义一个结果集，存放查询的数据
    FMResultSet *rs = [_db executeQuery:@"SELECT * from optionResult"];
    
    //判断结果集中是否有数据，如果有则取出数据
    while ([rs next])
    {
        [dataArray addObject:[rs resultDictionary]];
    }
    
    [self closeDatabase];
    
    return dataArray;
}

- (NSUInteger)getOptionResultCount
{
    //打开数据库，如果没有打开，直接返回
    if(![self openDatabase])
        return 0;
    
    if(![_db tableExists:@"optionResult"])
    {
        return 0;
    }
    
    FMResultSet *rs = [_db executeQuery:@"SELECT count(*) as 'count' FROM optionResult"];
    
    while ([rs next])
    {
    
        NSInteger count = [rs intForColumn:@"count"];
        return count;
    }
    
    return 0;
}

@end
