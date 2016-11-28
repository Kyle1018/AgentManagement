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

        /*
        [self.requestParameters safeSetObject:dic[@"identifyCode"] forKey:@"code"];
        [self.requestParameters safeSetObject:dic[@"password"] forKey:@"password"];
        [self.requestParameters safeSetObject:dic[@"phone"] forKey:@"phone"];
         */
        
        [self.requestParameters safeSetObject:dic[@"identifyCode"] forKey:@"code"];
        [self.requestParameters safeSetObject:dic[@"password"] forKey:@"password"];
        [self.requestParameters safeSetObject:dic[@"phone"] forKey:@"phone"];
        
    }
    return self;
}

- (NSString *)urlPath
{
    return @"apiuser/xiugai";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
     return [dictionary objectForKey:@"resultCode"];
}


@end
