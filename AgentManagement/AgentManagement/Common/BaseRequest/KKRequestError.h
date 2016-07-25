//
//  KKRequestError.h
//  PuRunMedical
//
//  Created by Kyle on 16/6/20.
//  Copyright © 2016年 PuRun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKRequestError : NSObject

- (instancetype)initWithError:(NSError *)error;
- (instancetype)initWithErrorCode:(NSInteger)code errorMessage:(NSString *)message;

- (NSInteger)errorCode;
- (NSString *)errorMessage;

@end
