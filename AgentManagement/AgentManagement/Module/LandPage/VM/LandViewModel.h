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
@interface LandViewModel : NSObject

@property (nonatomic, strong) AMIdentifyCodeRequest *identifyCodeRequest;

@property(nonatomic,strong)AMRegisterRequest *registerRequest;

- (RACSignal*)requestIdentifyCode:(NSString*)phone;//请求验证码

- (RACSignal*)requestRegisterWithRegisterInformation:(NSDictionary*)dic;

@end
