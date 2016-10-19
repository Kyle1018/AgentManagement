//
//  AMAdministratorViewModel.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAdministratorViewModel.h"

@implementation AMAdministratorViewModel

- (RACSignal *)refreshAdministratorSignal {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
    
    return [signal takeUntil:self.rac_willDeallocSignal];
}

- (RACSignal *)loadMoreAdministratorSignal {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
    
    return [signal takeUntil:self.rac_willDeallocSignal];
}

@end
