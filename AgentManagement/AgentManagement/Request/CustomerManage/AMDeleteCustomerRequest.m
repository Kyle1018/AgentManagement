//
//  AMDeleteCustomerRequest.m
//  AgentManagement
//
//  Created by huabin on 16/9/21.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMDeleteCustomerRequest.h"

@implementation AMDeleteCustomerRequest

- (instancetype)initWithCustomerID:(NSInteger)c_id;
{
    self = [super init];
    if (self) {
        
        if (self != nil) {
            
            NSString *str = [NSString stringWithFormat:@"%ld",c_id];
            [self.requestParameters safeSetObject:str forKey:@"id"];
            
        }
        
    }
    return self;
}


- (NSString *)urlPath
{
    return @"apicustomer/delete";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    
    
    DDLogDebug(@"%@",dictionary);
    
    
    return nil;
    
  //  return [[AMCustomer alloc]initWithDictionary:dictionary error:nil];
    
}

@end
