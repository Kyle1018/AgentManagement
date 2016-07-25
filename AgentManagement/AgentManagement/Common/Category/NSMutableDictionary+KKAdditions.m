//
//  NSMutableDictionary+KKAdditions.m
//  PuRunMedical
//
//  Created by Kyle on 16/7/18.
//  Copyright © 2016年 PuRun. All rights reserved.
//

#import "NSMutableDictionary+KKAdditions.h"

@implementation NSMutableDictionary (KKAdditions)

- (void)safeSetObject:(id)object forKey:(id<NSCopying>)key
{
    if (object && key) {
        [self setObject:object forKey:key];
    }
}

@end
