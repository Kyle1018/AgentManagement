//
//  CustomerManageViewModel.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/11.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMAddCustomerRequest.h"
@interface CustomerManageViewModel : NSObject

@property(nonatomic,strong)NSArray *areaArray;

@property(nonatomic,strong)AMAddCustomerRequest *addCustomerRequest;

//获取地区数据
- (RACSignal*)requestAreaListData:(NSInteger)index lIndex:(NSInteger)lIndex;


- (RACSignal*)requestCustomerInfoListDataOrSearchCustomerInfoDataWithPage:(NSInteger)page size:(NSInteger)size search:(NSDictionary*)searchDic;

//添加客户
- (RACSignal*)requstAddCustomerData:(NSDictionary*)paramt;

@end
