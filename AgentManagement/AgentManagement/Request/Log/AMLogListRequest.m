//
//  AMLogListRequest.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMLogListRequest.h"

@implementation AMLogListRequest

- (instancetype)initWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
    self = [super init];
    if (self) {
        [self.requestParameters safeSetObject:@"10" forKey:@"user_id"];
        [self.requestParameters safeSetObject:@(pageIndex) forKey:@"pageIndex"];
        [self.requestParameters safeSetObject:@(pageSize) forKey:@"pageSize"];
    }
    return self;
}

- (NSString *)urlPath {
    return @"apilog/search";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary {
    return nil;
}

@end
