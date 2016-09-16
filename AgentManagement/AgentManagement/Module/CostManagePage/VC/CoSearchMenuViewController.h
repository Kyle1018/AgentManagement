//
//  CoSearchMenuViewController.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapSearchProductBlock)(NSMutableDictionary*selectedOptionDic);

@interface CoSearchMenuViewController : UIViewController

@property(nonatomic,strong)NSMutableArray *brandAndPmodelDataArray;

@property(nonatomic,copy)TapSearchProductBlock tapSearchProductBlock;

@end
