//
//  LandViewModel.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMIdentifyCodeRequest.h"
#import "AMRegisterRequest.h"
#import "AMLoginRequest.h"
#import "PhoneRegisterStateRequest.h"
//#import "AMModifyPasswordRequest.h"
#import "AMBackPassword.h"
@interface LandViewModel : NSObject

@property (nonatomic, strong) AMIdentifyCodeRequest *identifyCodeRequest;

@property(nonatomic,strong)AMRegisterRequest *registerRequest;

@property(nonatomic,strong)AMLoginRequest *loginRequest;

@property(nonatomic,strong)PhoneRegisterStateRequest *phoneRegisterStateRequest;

//@property(nonatomic,strong)AMModifyPasswordRequest *modifyPasswordRequest;

@property(nonatomic,strong)AMBackPassword *backPassword;

- (RACSignal*)requestIdentifyCode:(NSString*)phone;//请求验证码

- (RACSignal*)requestRegisterWithRegisterInformation:(NSDictionary*)dic;//注册请求

- (RACSignal*)requestSigninWithUserName:(NSString*)userName Password:(NSString*)password;//登录请求

- (RACSignal*)requestPhoneNumRegisterState:(NSString*)phone;//手机号是否注册过

- (RACSignal*)requestBackPasswordWithLandInformation:(NSDictionary*)dic;//找回密码
@end
