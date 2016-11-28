//
//  DataAnalysisViewModel.h
//  AgentManagement
//
//  Created by huabin on 16/10/14.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataAnalysisViewModel : NSObject


//请求库存量
- (RACSignal*)requestStock;

//请求销售量
- (RACSignal*)requestLSalesVolume;

@end
