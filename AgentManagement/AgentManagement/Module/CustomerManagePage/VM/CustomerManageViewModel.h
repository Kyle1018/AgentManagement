//
//  CustomerManageViewModel.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/11.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMAddCustomerRequest.h"
#import "AMSalerListOrSearchRequest.h"
#import "AMAdministratorListOrSearchRequest.h"
@interface CustomerManageViewModel : NSObject

@property(nonatomic,strong)NSArray *areaArray;

@property(nonatomic,strong)AMAddCustomerRequest *addCustomerRequest;

@property(nonatomic,strong)AMSalerListOrSearchRequest *request1;

@property(nonatomic,strong) AMAdministratorListOrSearchRequest *request2;
//获取地区数据
- (RACSignal*)requestAreaListData:(NSInteger)index lIndex:(NSInteger)lIndex;


- (RACSignal*)requestCustomerInfoListDataOrSearchCustomerInfoDataWithPage:(NSInteger)page size:(NSInteger)size search:(NSDictionary*)searchDic;

//添加客户
- (RACSignal*)requstAddCustomerData:(NSDictionary*)paramt;


//请求销售员列表——获取销售员的姓名
- (RACSignal*)requstSalersName;
//请求管理员列表——获取管理员姓名
- (RACSignal*)requestAdministratorName;

@end
