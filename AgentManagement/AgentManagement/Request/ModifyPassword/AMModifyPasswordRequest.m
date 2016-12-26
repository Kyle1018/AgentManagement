//
//  AMModifyPasswordRequest.m
//  AgentManagement
//
//  Created by huabin on 16/10/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMModifyPasswordRequest.h"

@implementation AMModifyPasswordRequest


- (instancetype)initWithLandInformation:(NSDictionary*)dic; {
    
    self = [super init];
    if (self) {

        [self.requestParameters addEntriesFromDictionary:dic];

    }
    return self;
}

- (NSString *)urlPath
{
    return @"nativeapi/register";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
   // NSLog(@"%@",dictionary);
    // return [dictionary objectForKey:@"resultCode"];
    
    return [[AMBaseModel alloc]initWithDictionary:dictionary error:nil];
}


@end
