//
//  AMAdministratorListOrSearchRequest.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAdministratorListOrSearchRequest.h"
#import "AMAdministrators.h"
@implementation AMAdministratorListOrSearchRequest


- (instancetype)initWithPage:(NSString *)page Size:(NSString*)size Search:(NSDictionary*)search
{
    self = [super init];
    if (self) {
        
        [self.requestParameters  safeSetObject:search forKey:@"search"];
        [self.requestParameters safeSetObject:page forKey:@"page"];
        [self.requestParameters safeSetObject:size forKey:@"size"];
        
    }
    return self;
}

- (NSString *)urlPath
{
    return @"apiadministrators/search";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
//    NSLog(@"%@",dictionary);
//    return nil;
     return [[AMAdministrators alloc]initWithDictionary:dictionary error:nil];
    
}

@end
