//
//  LandViewModel.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "LandViewModel.h"
#import "AMIdentifyCode.h"
#import "AMUser.h"
#import "AMUserManager.h"
@implementation LandViewModel

- (RACSignal*)requestIdentifyCode:(NSString*)phone {
    
    __block AMIdentifyCode *identifyCodeModel = nil;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.identifyCodeRequest = [[AMIdentifyCodeRequest alloc] initWithPhone:phone];
        [self.identifyCodeRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
  
            identifyCodeModel = (AMIdentifyCode*)model;
            
            if ([identifyCodeModel.data isEqualToString:@""]) {
                
                [subscriber sendNext:identifyCodeModel.resultMessage];
                [subscriber sendCompleted];
            }
            else {
             
                [subscriber sendNext:identifyCodeModel.data];
                [subscriber sendCompleted];
            }
         
        } failure:^(KKBaseModel *model, KKRequestError *error) {

            [subscriber sendNext:@"获取验证码失败"];
            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
}

- (RACSignal*)requestRegisterWithRegisterInformation:(NSDictionary*)dic {
  
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        self.registerRequest = [[AMRegisterRequest alloc]initWithPhone:dic[@"phone"] password:dic[@"new_password"] re_password:dic[@"re_password"] agree:dic[@"agree"] code:dic[@"code"]];

        [self.registerRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
       
            AMBaseModel*baseModel = (AMBaseModel*)model;
     
            [subscriber sendNext:baseModel.resultMessage];
            [subscriber sendCompleted];
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
            [subscriber sendError:error];
        }];
        
        
        return nil;
    }];
}

- (RACSignal*)requestSigninWithUserName:(NSString*)userName Password:(NSString*)password {
    
    __block AMUser *loginModel = nil;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.loginRequest = [[AMLoginRequest alloc]initWithAccount:userName password:password];
        
        [self.loginRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {

            
            loginModel = (AMUser*)model;
            
      
            kSharedUserManager.user = loginModel;
            [subscriber sendNext:loginModel];
            [subscriber sendCompleted];
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
         
            [subscriber sendError:error];

        }];
        
        return nil;
    }];
}

- (RACSignal*)requestPhoneNumRegisterState:(NSString*)phone {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.phoneRegisterStateRequest = [[PhoneRegisterStateRequest alloc]initWithPhone:phone];
        
        [self.phoneRegisterStateRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            [subscriber sendNext: (NSNumber*)model];
            [subscriber sendCompleted];
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

//找回密码
- (RACSignal*)requestBackPasswordWithLandInformation:(NSDictionary*)dic {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.backPassword = [[AMBackPassword alloc]initWithBackPasswordInformation:dic];
        
        [self.backPassword requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMBaseModel *baseModel = (AMBaseModel*)model;
            
            [subscriber sendNext:baseModel.resultMessage];
            [subscriber sendCompleted];
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (RACSignal*)requestAddEPinformation:(NSDictionary*)dic {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.EPinformationRequest = [[AMEPinformationRequest alloc]initWithEPInformation:dic];
        
        [self.EPinformationRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
}//完善企业信息

@end
