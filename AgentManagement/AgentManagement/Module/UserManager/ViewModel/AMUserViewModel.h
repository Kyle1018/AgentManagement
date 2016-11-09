//
//  AMUserViewModel.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMUserViewModel : NSObject

- (RACSignal *)modifyPasswordSignalWithCurrentPassword:(NSString *)currentPassword inputPassword:(NSString *)inputPassword confirmPassword:(NSString *)confirmPassword;

- (RACSignal *)modifyUserSignal:(AMUser *)user;

@end
