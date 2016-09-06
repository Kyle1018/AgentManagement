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
            
            NSLog(@"%@",self.requestParameters);
//            [self.requestParameters addEntriesFromDictionary:productInfo];
//           [self.requestParameters  safeSetObject:search forKey:@"search"];
//            [self.requestParameters safeSetObject:page forKey:@"page"];
//            [self.requestParameters safeSetObject:size forKey:@"size"];
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
    NSLog(@"%@",dictionary);
    
    return [[AMProductInfo alloc]initWithDictionary:dictionary error:nil];
   
}

@end
