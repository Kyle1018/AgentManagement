//
//  LandViewModel.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMIdentifyCodeRequest.h"
#import "AMIdentifyCode.h"

@interface LandViewModel : NSObject

@property (nonatomic, strong) AMIdentifyCodeRequest *request;

//@property(nonatomic,copy)NSString *identifyCode;

- (RACSignal*)requestIdentifyCode;

@end
