//
//  AMCustomerOrSearchRequest.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/12.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMCustomerOrSearchRequest.h"

@implementation AMCustomerOrSearchRequest

- (instancetype)initWithPage:(NSInteger)page Size:(NSInteger)size Search:(NSDictionary*)search
{
    self = [super init];
    if (self) {
        
        [self.requestParameters  safeSetObject:search forKey:@"search"];
        [self.requestParameters safeSetObject:@(page) forKey:@"page"];
        [self.requestParameters safeSetObject:@(size) forKey:@"size"];
        
    }
    return self;
}

- (NSString *)urlPath
{
    return @"apicustomer/search";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    
    NSLog(@"%@",dictionary);
    return [[AMBaseModel alloc]initWithDictionary:dictionary error:nil];
   // return [[AMProductInfo alloc]initWithDictionary:dictionary error:nil];
    
}
@end
