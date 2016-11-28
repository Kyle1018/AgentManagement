//
//  AMModifyAdministratorRequest.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMModifyAdministratorRequest.h"

@implementation AMModifyAdministratorRequest

- (instancetype)initWithAdministratorID:(NSString *)administratorID nickname:(NSString *)nickname phone:(NSString *)phone area:(NSString *)area {
    self = [super init];
    if (self) {
        [self.requestParameters safeSetObject:administratorID forKey:@"id"];
        [self.requestParameters safeSetObject:nickname forKey:@"nickname"];
        [self.requestParameters safeSetObject:phone forKey:@"tphone"];
        [self.requestParameters safeSetObject:area forKey:@"city"];
    }
    return self;
}

- (NSString *)urlPath {
    return @"apiadministrators/edit";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary {
    return nil;
}

@end
