//
//  AMSearchAdministratorView.h
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SearchAdministratorBlock)(NSString *name, NSString *phone, NSString *area);

@interface AMSearchAdministratorView : UIView

@property (nonatomic, copy) SearchAdministratorBlock searchBlock;

@end
