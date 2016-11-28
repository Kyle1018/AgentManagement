//
//  AMUserManager.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMUserManager.h"

static AMUserManager *sharedUserManager = nil;

@implementation AMUserManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedUserManager = [[[self class] alloc] init];
    });
    return sharedUserManager;
}

@end
