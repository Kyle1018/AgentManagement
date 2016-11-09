//
//  AMAdministratorListRequest.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAdministratorListRequest.h"

@implementation AMAdministratorListRequest

- (instancetype)initWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize name:(NSString *)name phone:(NSString *)phone area:(NSString *)area {
    self = [super init];
    if (self) {
        [self.requestParameters safeSetObject:@(pageIndex) forKey:@"page"];
        [self.requestParameters safeSetObject:@(pageSize) forKey:@"size"];
#warning key
    }
    return self;
}

- (NSString *)urlPath {
    return @"apiadministrators/search";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary {
    return nil;
}

@end
