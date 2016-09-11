//
//  CustomerManageViewModel.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/11.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerManageViewModel : NSObject

@property(nonatomic,strong)NSArray *areaArray;

- (RACSignal*)requestAreaListData:(NSInteger)index lIndex:(NSInteger)lIndex;

@end
