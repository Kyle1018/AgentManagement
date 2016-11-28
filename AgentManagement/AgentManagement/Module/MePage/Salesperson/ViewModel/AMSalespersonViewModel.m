//
//  AMSalespersonViewModel.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMSalespersonViewModel.h"

@implementation AMSalespersonViewModel

- (RACSignal *)refreshSalespersonSignal {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
    
    return [signal takeUntil:self.rac_willDeallocSignal];
}

- (RACSignal *)loadMoreSalespersonSignal {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
    
    return [signal takeUntil:self.rac_willDeallocSignal];
}

@end
