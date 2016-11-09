//
//  AMSalespersonListRequest.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMSalespersonListRequest.h"

@implementation AMSalespersonListRequest

- (instancetype)initWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize name:(NSString *)name phone:(NSString *)phone area:(NSString *)area {
    self = [super init];
    if (self) {
        [self.requestParameters safeSetObject:@(pageIndex) forKey:@""];
        [self.requestParameters safeSetObject:@(pageSize) forKey:@""];
    }
    return self;
}

- (NSString *)urlPath {
    return @"apisales/search";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary {
    return nil;
}

@end
