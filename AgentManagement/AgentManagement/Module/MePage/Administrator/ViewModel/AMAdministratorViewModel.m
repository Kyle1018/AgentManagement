//
//  AMAdministratorViewModel.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAdministratorViewModel.h"
#import "AMAdministratorListRequest.h"

const NSUInteger kPageSize = 10;

@interface AMAdministratorViewModel () {
    NSInteger _pageIndex;
}

@property (nonatomic, strong) AMAdministratorListRequest *request;

@end

@implementation AMAdministratorViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self resetData];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)resetData {
    _pageIndex = 1;
}

- (RACSignal *)administratorListSignalWithPageIndex:(NSInteger)pageIndex {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        self.request = [[AMAdministratorListRequest alloc] initWithPageIndex:pageIndex pageSize:kPageSize name:nil phone:nil area:nil];
        
        [self.request requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            NSLog(@"%@", model);
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            _pageIndex--;
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [self.request cancel];
        }];
    }];
    
    return [signal takeUntil:self.rac_willDeallocSignal];
}

- (RACSignal *)refreshAdministratorSignal {
    [self resetData];
    return [self administratorListSignalWithPageIndex:_pageIndex];
}

- (RACSignal *)loadMoreAdministratorSignal {
    _pageIndex++;
    return [self administratorListSignalWithPageIndex:_pageIndex];
}

@end
