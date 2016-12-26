//
//  AMBaseModel.m
//  AgentManagement
//
//  Created by Kyle on 16/8/13.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMBaseModel.h"

@implementation AMBaseModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    id dataDictionary = dict[@"data"];
    
    if (dataDictionary && [dataDictionary isKindOfClass:[NSDictionary class]]) {
        self = [super initWithDictionary:dataDictionary error:err];
        self.resultCode = dict[@"resultCode"];
        self.resultMessage = dict[@"resultMessage"];
    }else {
        self = [super initWithDictionary:dict error:err];
    }
    return self;
}

- (BOOL)isValid
{
    return (self.resultCode && self.resultCode.integerValue == 0);
}

@end
