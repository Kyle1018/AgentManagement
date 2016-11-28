//
//  AMUserManager.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMUser.h"

#define kSharedUserManager [AMUserManager sharedInstance]

@interface AMUserManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) AMUser *user;

@end
