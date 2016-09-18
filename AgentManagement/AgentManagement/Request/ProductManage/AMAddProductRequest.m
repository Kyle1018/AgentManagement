//
//  AMAddProductRequest.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/30.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAddProductRequest.h"
#import "AMProductInfo.h"
@implementation AMAddProductRequest

- (instancetype)initWithAddProductInfo:(NSDictionary*)productInfo
{
    self = [super init];
    if (self) {
        
        if (self != nil) {

            [self.requestParameters safeAddEntriesFromDictionary:productInfo];
            
        }

    }
    return self;
}


- (NSString *)urlPath
{
    return @"apiproduct/add";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    DDLogDebug(@"%@",dictionary);
    
    return [[AMProductInfo alloc]initWithDictionary:dictionary error:nil];
   
}

@end
