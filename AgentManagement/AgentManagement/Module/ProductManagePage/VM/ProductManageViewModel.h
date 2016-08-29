//
//  ProductManageViewModel.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMProductAndModelListRequest.h"
#import "AMProductRelatedInformationRequest.h"
@interface ProductManageViewModel : NSObject

@property(nonatomic,strong)AMProductAndModelListRequest *pmRequest;

@property(nonatomic,strong)AMProductRelatedInformationRequest *priRequest;

@property(nonatomic,strong)NSMutableArray *productRelatedInformationArray;

- (RACSignal*)requestProductAndModelListData;

- (RACSignal*)requestProductRelatedInformationData;
@end
