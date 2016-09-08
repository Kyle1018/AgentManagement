//
//  AMDeleteProductRequest.m
//  AgentManagement
//
//  Created by huabin on 16/9/8.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMDeleteProductRequest.h"

@implementation AMDeleteProductRequest

- (instancetype)initWithPD_id:(NSDictionary*)pdInfo {
    
    self = [super init];
    if (self) {
        
        //[self.requestParameters safeSetObject:pd_id forKey:@"id"];
 
           [self.requestParameters safeAddEntriesFromDictionary:pdInfo];
    }

    return self;
}

- (NSString *)urlPath
{
    return @"apiproduct/delete";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    NSLog(@"%@",dictionary);
    
    return nil;
    
   // return [[AMProductInfo alloc]initWithDictionary:dictionary error:nil];
    
    //return [[AMAddProductInfo alloc]initWithDictionary:dictionary error:nil];
    
}

@end
