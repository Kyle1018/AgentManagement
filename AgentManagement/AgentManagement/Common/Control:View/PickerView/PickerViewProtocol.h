//
//  PickerViewProtocol.h
//  AgentManagement
//
//  Created by huabin on 16/9/23.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DidSelectRow)(NSInteger row,NSInteger component);

@interface PickerViewProtocol : NSObject<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)NSMutableArray *pickerDataArray;

@property(nonatomic,strong)NSMutableArray *pickerDataArrayB;

@property(nonatomic,strong)NSMutableArray *pickerDataArrayC;

@property(nonatomic,copy)DidSelectRow didSelectRow;

@end
