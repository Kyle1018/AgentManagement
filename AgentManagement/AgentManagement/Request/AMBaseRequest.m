//
//  AMBaseRequest.m
//  AgentManagement
//
//  Created by Kyle on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"
#import "ASIFormDataRequest.h"
#import "NSDictionary+KKAdditions.h"
#import "NSData+KKAdditions.h"
#import "Reachability.h"
static NSString *const kAPIBaseURL = @"http://123.56.10.232:81/index.php?r=";

@interface AMBaseRequest ()<ASIHTTPRequestDelegate>

@property (nonatomic, strong) ASIFormDataRequest *request;
@property (nonatomic, strong) NSMutableData *receiveData;

@property (nonatomic, copy) KKRequestSuccess requestSuccess;
@property (nonatomic, copy) KKRequestFailure requestFailure;

@property (nonatomic, assign) NSUInteger currentRetryCount;

@end

@implementation AMBaseRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.retryCount = 0;
        self.retryTimeInterval = 0.;
        self.isUseCache = NO;
        self.request.useCookiePersistence = YES;
     
    }
    return self;
}

- (NSDictionary *)commonParameters
{
    return @{};
}

- (NSMutableDictionary *)requestParameters
{
    if (!_requestParameters) {
        _requestParameters = [NSMutableDictionary dictionary];
    }
    return _requestParameters;
}

- (KKHttpMethodType)httpMethodType
{
    return KKHttpMethodType_POST;
}

- (NSString *)apiBaseURL
{
    return kAPIBaseURL;
}

- (NSString *)urlPath
{
    return nil;
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    return nil;
}

- (void)requestWithSuccess:(KKRequestSuccess)success failure:(KKRequestFailure)failure
{
    self.requestSuccess = success;
    self.requestFailure = failure;
    self.receiveData = [NSMutableData data];
    
        switch ([self httpMethodType]) {
            case KKHttpMethodType_GET: {
                [self makeGetRequest];
                
                break;
            } case KKHttpMethodType_POST: {
                [self makePostRequest];
                
                break;
            } default:
                break;
        }

}

- (NSDictionary *)buildParameters
{
    NSMutableDictionary *httpDictionary = [[self commonParameters] mutableCopy];
    
    for (id key in self.requestParameters) {
        [httpDictionary setObject:self.requestParameters[key] forKey:key];
    }
    return [httpDictionary copy];
}

- (NSString *)buildRequestURL
{
    NSAssert(([self apiBaseURL] != nil), @"apiBaseURL不能为空");
    NSAssert(([self urlPath] != nil), @"urlPath不能为空");
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", [self apiBaseURL], [self urlPath]];
    
    return requestURL;
}

- (void)makeGetRequest
{
    NSDictionary *parameters = [self buildParameters];
    
    self.request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[self buildRequestURL]]];
    self.request.requestMethod = @"GET";
    self.request.allowCompressedResponse = YES;
    self.request.delegate = self;
    if ([parameters allKeys].count > 0) {
        for (NSString *key in [parameters allKeys]) {
            [self.request addRequestHeader:key value:parameters[key]];
        }
    }
    [self.request startAsynchronous];
}

- (void)makePostRequest
{
    NSDictionary *parameters = [self buildParameters];
    NSString *parametersJSON = [parameters convertToJSONString];
    
    self.request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[self buildRequestURL]]];
    self.request.requestMethod = @"POST";
    self.request.allowCompressedResponse = YES;
    self.request.delegate = self;
    if (parametersJSON) {
        
        [self.request setPostValue:parametersJSON forKey:@"data"];
    }
    [self.request startAsynchronous];
    

}

- (void)handleResultWithRequest:(ASIHTTPRequest *)request
{
    if (request.responseStatusCode == 200) {
        [self handleSuccessWithRequest:request];
    } else {
        [self handleFailureWithRequest:request];
    }
}

- (void)handleSuccessWithRequest:(ASIHTTPRequest *)request
{
    NSDictionary *responseDictionary = [self.receiveData convertToDictionary];
    
    if (responseDictionary) {
        if (self.isUseCache) {
            [self cacheResponseObject:responseDictionary];
        }
        
        if (self.requestSuccess) {
            self.requestSuccess([self buildModelWithJsonDictionary:responseDictionary], nil);
            self.requestSuccess = nil;
        }
    } else {
        DDLogError(@"responseDictionary为空");
    }
}

- (void)handleFailureWithRequest:(ASIHTTPRequest *)request
{
    if ((self.retryCount > 0) && (++self.currentRetryCount < self.retryCount)) {
#warning dispatch_after 若interval为0，调用为同步还是异步?
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.retryTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestWithSuccess:self.requestSuccess failure:self.requestFailure];
        });
        return;
    }
    
    if (self.requestFailure) {
        
        self.requestFailure(nil, [[KKRequestError alloc] initWithError:request.error]);
        self.requestFailure = nil;
    }
}

- (void)cancel
{
    self.requestSuccess = nil;
    self.requestFailure = nil;
    self.request.delegate = nil;
    [self.request cancel];
}

#pragma mark - KKCache

- (NSString *)cacheFileDirectory
{
    return nil;
}

- (NSString *)cacheFilePath
{
    return nil;
}

- (id)getCacheObject
{
    NSString *directory = [self cacheFileDirectory];
    NSString *path = [self cacheFilePath];
    
    NSAssert(((directory != nil) && (path != nil)), @"缓存文件夹&文件路径不能为空, cacheFileDirectory = %@, cacheFilePath = %@", directory, path);
    NSDictionary *dictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@%@", directory, path]];
    
    if (dictionary) {
        return [self buildModelWithJsonDictionary:dictionary];
    } else {
        return nil;
    }
}

- (void)cacheResponseObject:(NSDictionary *)responseObject
{
#warning 进一步明确archive的使用及存储数据形式
    NSString *directory = [self cacheFileDirectory];
    NSString *path = [self cacheFilePath];
    
    NSAssert(((directory != nil) && (path != nil)), @"缓存文件夹&文件路径不能为空, cacheFileDirectory = %@, cacheFilePath = %@", directory, path);
    [NSKeyedArchiver archiveRootObject:responseObject toFile:[NSString stringWithFormat:@"%@%@", directory, path]];
}

#pragma mark - ASIHTTPRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self handleResultWithRequest:request];
}

- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    if (data && [data isKindOfClass:[NSData class]]) {
        [self.receiveData appendData:data];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self handleResultWithRequest:request];
}


@end
