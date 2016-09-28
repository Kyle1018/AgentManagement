//
//  AMEditProductRequest.m
//  AgentManagement
//
//  Created by huabin on 16/9/28.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMEditProductRequest.h"
#import "AMProductInfo.h"
@implementation AMEditProductRequest

- (instancetype)initWithEditProductInfo:(NSDictionary*)productInfo
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
    return @"apiproduct/edit";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    DDLogDebug(@"%@",dictionary);
    
     return [[AMProductInfo alloc]initWithDictionary:dictionary error:nil];
}

@end
