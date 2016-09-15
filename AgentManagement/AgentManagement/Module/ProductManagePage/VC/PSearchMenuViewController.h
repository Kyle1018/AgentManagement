//
//  SearchMenuViewController.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapSearchProductBlock)(NSMutableDictionary*selectedOptionDic);

@interface PSearchMenuViewController : UIViewController

@property(nonatomic,strong)NSArray *productRelatedInformationArray;

@property(nonatomic,copy)TapSearchProductBlock tapSearchProductBlock;

@end
