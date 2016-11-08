//
//  PhoneRegisterStateRequest.m
//  AgentManagement
//
//  Created by huabin on 16/10/20.
//  Copyright © 2016年 KK. All rights reserved.
//

//http://123.56.10.232:81/index.php?r=apiuser/getphone&phone=12345678901

#import "PhoneRegisterStateRequest.h"

@implementation PhoneRegisterStateRequest

- (instancetype)initWithPhone:(NSString *)phone
{
    self = [super init];
    if (self) {
        [self.requestParameters safeSetObject:phone forKey:@"phone"];
    }
    return self;
}

- (NSString *)urlPath
{
    return @"apiuser/getphone";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{

    return [dictionary objectForKey:@"data"];
}


@end
