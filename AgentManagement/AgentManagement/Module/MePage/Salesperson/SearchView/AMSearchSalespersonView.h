//
//  AMSearchSalespersonView.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SearchSalespersonBlock)(NSString *name, NSString *phone, NSString *area);

@interface AMSearchSalespersonView : UIView

@property (nonatomic, copy) SearchSalespersonBlock searchBlock;

@end
