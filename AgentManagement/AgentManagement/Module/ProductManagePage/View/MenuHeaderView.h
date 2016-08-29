//
//  MenuHeaderView.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapAllButonBlock)();

@interface MenuHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *hederTitle;

@property(nonatomic,copy)TapAllButonBlock tapAllButonBlock;

@end
