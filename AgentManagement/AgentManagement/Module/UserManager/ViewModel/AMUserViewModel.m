//
//  AMUserViewModel.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMUserViewModel.h"
#import "AMUpdatePasswordRequest.h"
#import "AMModifyUserRequest.h"

@implementation AMUserViewModel

- (RACSignal *)modifyPasswordSignalWithCurrentPassword:(NSString *)currentPassword inputPassword:(NSString *)inputPassword confirmPassword:(NSString *)confirmPassword {
    if ((currentPassword.length <= 0) || (inputPassword.length <= 0) || (confirmPassword.length <= 0)) {
        return [RACSignal error:[[KKRequestError alloc] initWithErrorCode:kDefaultErrorCode errorMessage:@"密码不能为空"]];
    }
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AMUpdatePasswordRequest *request = [[AMUpdatePasswordRequest alloc] initWithCurrentPassword:currentPassword inputPassword:inputPassword confirmPassword:confirmPassword];
        
        [request requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            if ([model isValid]) {
                [subscriber sendCompleted];
            } else {
                AMBaseModel *resultModel = (AMBaseModel *)model;
                
                [subscriber sendError:[[KKRequestError alloc] initWithErrorCode:resultModel.resultCode.integerValue errorMessage:resultModel.resultMessage]];
            }
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [request cancel];
        }];
    }];
    
    return [signal takeUntil:self.rac_willDeallocSignal];
}

- (RACSignal *)modifyUserSignal:(AMUser *)user {
    if (!user) {
        return [RACSignal error:[[KKRequestError alloc] initWithErrorCode:kDefaultErrorCode errorMessage:@"用户数据为空"]];
    }
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AMModifyUserRequest *request = [[AMModifyUserRequest alloc] initWithUser:user];
        
        [request requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            AMUser *resultModel = (AMUser *)model;
            
            if ([resultModel isValid]) {
                kSharedUserManager.user = resultModel;
                [subscriber sendCompleted];
            } else {
                [subscriber sendError:[[KKRequestError alloc] initWithErrorCode:resultModel.resultCode.integerValue errorMessage:resultModel.resultMessage]];
            }
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [request cancel];
        }];
    }];
    return [signal takeUntil:self.rac_willDeallocSignal];
}

@end
