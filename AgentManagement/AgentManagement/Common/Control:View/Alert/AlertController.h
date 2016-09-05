//
//  AlertController.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/20.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>



typedef void(^TapActionButtonBlock)(NSInteger alertTag,NSString* keyName,NSInteger index);//选项点击

typedef void(^TapExitButtonBlock)();

@interface AlertController : UIAlertController

@property(nonatomic,strong)NSArray *actionButtonArray;

@property(nonatomic,copy)TapActionButtonBlock tapActionButtonBlock;

@property(nonatomic,copy)TapExitButtonBlock tapExitButtonBlock;

@property(nonatomic,strong)NSArray *alertOptionName;

@property(nonatomic,assign)NSInteger alertTag;

@end
