//
//  CSearchMenuViewController.h
//  AgentManagement
//
//  Created by huabin on 16/8/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapSearchProductBlock)(NSMutableDictionary*selectedOptionDic);
@interface CSearchMenuViewController : UIViewController
@property(nonatomic,copy)TapSearchProductBlock tapSearchProductBlock;
@end
