//
//  NSDictionary+KKAdditions.h
//  AgentManagement
//
//  Created by Kyle on 16/8/27.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (KKAdditions)

- (NSData *)convertToData;

- (NSString *)convertToJSONString;

@end
