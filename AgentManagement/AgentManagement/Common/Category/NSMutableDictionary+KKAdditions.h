//
//  NSMutableDictionary+KKAdditions.h
//  PuRunMedical
//
//  Created by Kyle on 16/7/18.
//  Copyright © 2016年 PuRun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (KKAdditions)

- (void)safeSetObject:(nonnull id)object forKey:(nonnull id<NSCopying>)key;

@end
