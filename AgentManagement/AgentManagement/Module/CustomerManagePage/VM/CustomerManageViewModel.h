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
#import "AMCustomerOrSearchRequest.h"
#import "AMDeleteCustomerRequest.h"
#import "AMEditCustomerRequest.h"
@interface CustomerManageViewModel : NSObject

@property(nonatomic,strong)NSArray *areaArray;

@property(nonatomic,strong)AMAddCustomerRequest *addCustomerRequest;

@property(nonatomic,strong)AMSalerListOrSearchRequest *request1;

@property(nonatomic,strong) AMAdministratorListOrSearchRequest *request2;

@property(nonatomic,strong)AMCustomerOrSearchRequest *customerOrSearchRequest;

@property(nonatomic,strong)AMDeleteCustomerRequest *deleteCustomerRequest;

@property(nonatomic,strong)AMEditCustomerRequest *editCustomerRequest;

@property(nonatomic,strong)NSMutableArray *customerModelArray;
//获取地区数据
- (RACSignal*)requestAreaListData:(NSInteger)index lIndex:(NSInteger)lIndex;

//请求客户管理列表数据
//请求筛选客户信息数据
- (RACSignal*)requestCustomerInfoListDataOrSearchCustomerInfoDataWithPage:(NSInteger)page size:(NSInteger)size search:(NSDictionary*)searchDic;

//添加客户
- (RACSignal*)requstAddCustomerData:(NSDictionary*)paramt;

//删除客户
- (RACSignal*)requestDeleteCustomer:(NSInteger)c_id;

//编辑客户
- (RACSignal*)requestEditingCustomer:(NSDictionary*)paramt;

//请求销售员列表——获取销售员的姓名
- (RACSignal*)requstSalersList;

//请求管理员列表——获取管理员姓名
- (RACSignal*)requestAdministratorList;

@end
