//
//  SearchMenuViewController.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapSearchProductBlock)(NSMutableArray*listArray);

@interface PSearchMenuViewController : UIViewController

@property(nonatomic,strong)NSArray *productRelatedInformationArray;

@property(nonatomic,copy)TapSearchProductBlock tapSearchProductBlock;

@end
