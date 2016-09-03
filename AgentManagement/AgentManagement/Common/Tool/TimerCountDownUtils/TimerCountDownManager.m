//
//  TimerCountDownManager.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "TimerCountDownManager.h"



@interface CountdownTask : NSOperation

/**
 *  计时中回调
 */
@property (copy, nonatomic) void (^countingDownBlcok)(NSTimeInterval timeInterval);
/**
 *  计时结束后回调
 */
@property (copy, nonatomic) void (^finishedBlcok)(NSTimeInterval timeInterval);
/**
 *  计时剩余时间
 */
@property (assign, nonatomic) NSTimeInterval leftTimeInterval;
/**
 *  后台任务标识，确保程序进入后台依然能够计时
 */
@property (assign, nonatomic) UIBackgroundTaskIdentifier taskIdentifier;

/**
 *  `NSOperation`的`name`属性只在iOS8+中存在，这里定义一个属性，用来兼容 iOS7
 */
@property (copy, nonatomic) NSString *operationName;

@end


@implementation CountdownTask

//实现串行执行
- (void)main {
    
    //进入后台标识
    self.taskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];

    //剩余时间减减 大于0
    while (--_leftTimeInterval > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (_countingDownBlcok) _countingDownBlcok(_leftTimeInterval);
        });
        
        [NSThread sleepForTimeInterval:1];
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_finishedBlcok) {
            _finishedBlcok(0);
        }
    });
    
    if (self.taskIdentifier != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:self.taskIdentifier];
        self.taskIdentifier = UIBackgroundTaskInvalid;
    }
}

@end



@interface TimerCountDownManager ()

@property (nonatomic, strong) NSOperationQueue *pool;

@end

@implementation TimerCountDownManager


+ (instancetype)defaultManager {
    
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    
    return instance;
}


- (instancetype)init {
    if (self = [super init]) {
        
        _pool = [[NSOperationQueue alloc] init];
    }
    
    return self;
}


/*
 * aKey:传入的button标识
 *
 * timeInterval:倒计时时间60秒
 */
- (void)scheduledCountDownWithKey:(NSString *)aKey
                     timeInterval:(NSTimeInterval)timeInterval
                     countingDown:(void (^)(NSTimeInterval leftTimeInterval))countingDown
                         finished:(void (^)(__unused NSTimeInterval finalTimeInterval))finished {
    
    
    if (timeInterval > 120) {
        
        NSCAssert(NO, @"受操作系统后台时间限制，倒计时时间规定不得大于 120 秒.");
    }
    
    if (_pool.operations.count >= 20)  // 最多 20 个并发线程
        return;
    
    //一个任务
    CountdownTask *task = nil;
    if ([self countdownTaskExistWithKey:aKey task:&task]) {
        task.countingDownBlcok = countingDown;
        task.finishedBlcok     = finished;
        if (countingDown) {
            countingDown(task.leftTimeInterval);
        }
    }
    
    else {
        task                   = [[CountdownTask alloc] init];//创建一个任务
        task.leftTimeInterval  = timeInterval;//剩余时间60秒
        task.countingDownBlcok = countingDown;
        task.finishedBlcok     = finished;
        
        if ([@([UIDevice currentDevice].systemVersion.doubleValue) compare:@(8)] == NSOrderedAscending) {
            task.operationName = aKey;
        }
        
        else {
            task.name = aKey;
        }
        
        [_pool addOperation:task];
    }
    
}

- (BOOL)countdownTaskExistWithKey:(NSString *)akey
                             task:(CountdownTask *__autoreleasing  _Nullable*)task
{
    __block BOOL taskExist = NO;
    //左边的操作对象小于右边的对象——当前系统号小于ios8（ios7）
    if ([@([UIDevice currentDevice].systemVersion.doubleValue) compare:@(8)] == NSOrderedAscending) {
        

        [_pool.operations enumerateObjectsUsingBlock:^(__kindof CountdownTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            //如果这个任务的名字 等于 传进来的key
            if ([obj.operationName isEqualToString:akey]) {
                
                if (task) *task = obj;
                taskExist = YES;
                *stop     = YES;
            }
        }];
    }
    else {
        
        //首次进入队列中没有任务——返回no
        [_pool.operations enumerateObjectsUsingBlock:^(__kindof CountdownTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.name isEqualToString:akey]) {
                if (task) *task = obj;
                taskExist = YES;
                *stop     = YES;
            }
        }];
    }
    
    return taskExist;
}

@end
