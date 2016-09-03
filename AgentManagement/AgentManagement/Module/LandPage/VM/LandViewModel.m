//
//  LandViewModel.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "LandViewModel.h"

@implementation LandViewModel


- (RACSignal*)requestIdentifyCode {
    
    __weak typeof(self) weakSelf = self;
 
    __block AMIdentifyCode *identifyCodeModel = nil;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        weakSelf.request = [[AMIdentifyCodeRequest alloc] initWithPhone:@"13501167925"];
        [weakSelf.request requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            NSLog(@"%@", model);
            
            identifyCodeModel = (AMIdentifyCode*)model;
            
            if (identifyCodeModel.authCode) {
                
                RACTuple *tuple = RACTuplePack(identifyCodeModel.authCode,@(YES));
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }
            else {
                
                [subscriber sendNext:identifyCodeModel.resultMessage];
                [subscriber sendCompleted];
            }

    
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            NSLog(@"%@", model);
            
            identifyCodeModel = (AMIdentifyCode*)model;
            
            [subscriber sendNext:identifyCodeModel.resultMessage];
            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
}

@end
