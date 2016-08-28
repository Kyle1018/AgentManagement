//
//  MenuView.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/26.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MenuView : UIView

@property (weak, nonatomic) IBOutlet UITableView *menuTabelView;


+ (instancetype)createFromXibWithViewTag:(NSInteger)tag ToAddView:(UIView*)view;

- (void)show;

//- (void)hide;



@end

@interface MenuViewCell : UITableViewCell


+ (id)createFromXibWithMenuViewCell;

@property (weak, nonatomic) IBOutlet UIButton *optionA;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *optionB;


@end;




typedef void(^TapAllButtonBlock)();
@interface MenuCellHeaderView : UIView

+ (id)createFromXibWithMenuCellHeaderView;

@property(nonatomic,copy)TapAllButtonBlock tapAllButtonBlock;


@end
