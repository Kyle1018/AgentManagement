//
//  AMAddCustomerRequest.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/12.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAddCustomerRequest.h"

@implementation AMAddCustomerRequest


- (instancetype)initWithAddCustomerInfo:(NSDictionary*)customerInfo
{
    self = [super init];
    if (self) {
        
        if (self != nil) {
            
            [self.requestParameters safeAddEntriesFromDictionary:customerInfo];
            
        }
        
    }
    return self;
}


- (NSString *)urlPath
{
    return @"apicustomer/add";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    NSLog(@"%@",dictionary);
    
    
    return nil;
   // return [[AMProductInfo alloc]initWithDictionary:dictionary error:nil];
    
}

@end
