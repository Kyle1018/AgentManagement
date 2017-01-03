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
         
            /*
            
            if (identifyCodeModel.authCode) {
                
                RACTuple *tuple = RACTuplePack(identifyCodeModel.authCode,@(YES));
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }
            else {
                
                [subscriber sendNext:@"获取验证码失败"];
                [subscriber sendCompleted];
            }
            */
      

    
        } failure:^(KKBaseModel *model, KKRequestError *error) {
       
           // identifyCodeModel = (AMIdentifyCode*)model;
            
            [subscriber sendNext:@"获取验证码失败"];
            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
}

- (RACSignal*)requestRegisterWithRegisterInformation:(NSDictionary*)dic {
  
    __block AMUser *registerModel = nil;
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        self.registerRequest = [[AMRegisterRequest alloc]initWithPhone:dic[@"phone"] Password:dic[@"password"] Code:dic[@"identifyCode"]];
        
        [self.registerRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
       
            registerModel = (AMUser*)model;
           
            NSLog(@"dd");
            /*
            if (registerModel.an_id==0) {
                
                [subscriber sendNext:registerModel.resultMessage];
                [subscriber sendCompleted];
            }
            else {
                kSharedUserManager.user = registerModel;
                [subscriber sendNext:registerModel];
                [subscriber sendCompleted];
            }
             */
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
            [subscriber sendNext:registerModel.resultMessage];
            [subscriber sendCompleted];
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
            NSLog(@"dd");
            /*
            if (loginModel.an_id==0) {
                
                [subscriber sendNext:@"手机号或密码错误"];
                [subscriber sendCompleted];
            }
            else {
                kSharedUserManager.user = loginModel;
                [subscriber sendNext:loginModel];
                [subscriber sendCompleted];
            }
             */
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
         
            [subscriber sendNext:@"登录失败"];
            [subscriber sendCompleted];
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


//注册时设置密码
- (RACSignal*)requestModifyPasswordWithLandInformation:(NSDictionary*)dic {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        self.modifyPasswordRequest = [[AMModifyPasswordRequest alloc]initWithLandInformation:dic];
        
        [self.modifyPasswordRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
            
            AMBaseModel *baseModel = (AMBaseModel*)model;
            [subscriber sendNext:baseModel.resultMessage];
            [subscriber sendCompleted];
            
        } failure:^(KKBaseModel *model, KKRequestError *error) {
            
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

@end
