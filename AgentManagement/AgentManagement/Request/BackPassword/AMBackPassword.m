//
//  AMBackPassword.m
//  AgentManagement
//
//  Created by 郭华滨 on 17/1/16.
//  Copyright © 2017年 KK. All rights reserved.
//

#import "AMBackPassword.h"

@implementation AMBackPassword

- (instancetype)initWithBackPasswordInformation:(NSDictionary*)dic; {
    
    self = [super init];
    if (self) {
        
        [self.requestParameters addEntriesFromDictionary:dic];
        
    }
    return self;
}

- (NSString *)urlPath
{
    return @"nativeapi/resetPasswd";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
     NSLog(@"%@",dictionary);
    // return [dictionary objectForKey:@"resultCode"];
    
    return [[AMBaseModel alloc]initWithDictionary:dictionary error:nil];
}


@end
