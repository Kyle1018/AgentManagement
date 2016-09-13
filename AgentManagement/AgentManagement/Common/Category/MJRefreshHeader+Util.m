//
//  MJRefreshHeader+Util.m
//  iosapp
//
//  Created by suning2 on 16/7/5.
//  Copyright © 2016年 cyou. All rights reserved.
//

#import "MJRefreshHeader+Util.h"

@implementation MJRefreshHeader (Util)

+ (MJRefreshNormalHeader *)createTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    return header;
}

@end
