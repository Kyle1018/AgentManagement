//
//  AMAddSalespersonRequest.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAddSalespersonRequest.h"

@implementation AMAddSalespersonRequest

- (instancetype)initWithNickname:(NSString *)nickname phone:(NSString *)phone area:(NSString *)area {
    self = [super init];
    if (self) {
        [self.requestParameters safeSetObject:nickname forKey:@"name"];
        [self.requestParameters safeSetObject:phone forKey:@"phone"];
        [self.requestParameters safeSetObject:area forKey:@"area"];
    }
    return self;
}

- (NSString *)urlPath {
    return @"apisales/add";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary {
    return nil;
}

@end
