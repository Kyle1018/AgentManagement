//
//  AMEditCustomerRequest.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/25.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMEditCustomerRequest.h"

@implementation AMEditCustomerRequest

- (instancetype)initWithAddCustomerInfo:(NSDictionary*)customerInfo {
    
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
    return @"apicustomer/edit";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    
    
    DDLogDebug(@"%@",dictionary);
    
    
    return nil;
    
    //  return [[AMCustomer alloc]initWithDictionary:dictionary error:nil];
    
}


@end
