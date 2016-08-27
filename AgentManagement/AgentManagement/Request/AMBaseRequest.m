//
//  AMBaseRequest.m
//  AgentManagement
//
//  Created by Kyle on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseRequest.h"
#import <AFNetworking/AFNetworking.h>

static NSString *const kAPIBaseURL = @"http://123.56.10.232:81/index.php?r=";

@implementation AMBaseRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    }
    return self;
}

- (KKHttpMethodType)httpMethodType
{
    return KKHttpMethodType_POST;
}

- (NSDictionary *)commonParameters
{
    return @{};
}

- (NSString *)apiBaseURL
{
    return kAPIBaseURL;
}

- (NSString *)urlPath
{
    return @"";
}

@end