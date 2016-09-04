//
//  LandViewModel.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "LandViewModel.h"
#import "AMIdentifyCode.h"
#import "AMRegister.h"
@implementation LandViewModel


- (RACSignal*)requestIdentifyCode:(NSString*)phone {
    
    __weak typeof(self) weakSelf = self;
 
    __block AMIdentifyCode *identifyCodeModel = nil;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        weakSelf.identifyCodeRequest = [[AMIdentifyCodeRequest alloc] initWithPhone:phone];
        [weakSelf.identifyCodeRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
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


- (RACSignal*)requestRegisterWithRegisterInformation:(NSDictionary*)dic {
    
      __weak typeof(self) weakSelf = self;
    
       __block AMRegister *registerModel = nil;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        weakSelf.registerRequest = [[AMRegisterRequest alloc]initWithPhone:dic[@"phone"] Password:dic[@"password"] Code:dic[@"identifyCode"]];
        
        [weakSelf.registerRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
       
            registerModel = (AMRegister*)model;
            
            if (registerModel.an_id==0) {
                
                [subscriber sendNext:registerModel.resultMessage];
                [subscriber sendCompleted];
            }
            else {
                
                [subscriber sendNext:registerModel];
                [subscriber sendCompleted];
            }
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
            [subscriber sendNext:registerModel.resultMessage];
            [subscriber sendCompleted];
        }];
        
        
        return nil;
    }];
}

@end
