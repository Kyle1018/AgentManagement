//
//  AMLogViewModel.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMLogViewModel : NSObject

- (RACSignal *)refreshLogSignal;
- (RACSignal *)loadMoreLogSignal;

@end
