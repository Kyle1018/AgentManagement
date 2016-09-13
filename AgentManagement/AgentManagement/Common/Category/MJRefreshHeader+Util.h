//
//  MJRefreshHeader+Util.h
//  iosapp
//
//  Created by suning2 on 16/7/5.
//  Copyright © 2016年 cyou. All rights reserved.
//

#import "MJRefreshHeader.h"
#import <MJRefresh.h>

@interface MJRefreshHeader (Util)

+ (MJRefreshNormalHeader *)createTarget:(id)target refreshingAction:(SEL)action;

@end
