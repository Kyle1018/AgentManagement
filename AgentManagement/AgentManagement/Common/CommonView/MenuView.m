//
//  MenuView.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/26.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "MenuView.h"

@interface MenuView()

@end

@implementation MenuView

+ (instancetype)createFromXibWithViewTag:(NSInteger)tag ToAddView:(UIView*)view{
    
    //创建遮罩视图
    UIView*maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    maskView.backgroundColor=[UIColor blueColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [maskView addGestureRecognizer:tap];
    [view addSubview:maskView];
    
    //创建搜索菜单视图
    MenuView *menuView = [[[NSBundle mainBundle]loadNibNamed:@"MenuView" owner:nil options:nil]objectAtIndex:tag];
    menuView.frame = CGRectMake(ScreenWidth, 64, ScreenWidth-75,maskView.height);
    [view addSubview:menuView];

    //遮罩视图点击事件－点击后收起搜索菜单视图
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        
        [UIView animateWithDuration:1 animations:^{
            
            menuView.originX = ScreenWidth;
         
            
        } completion:^(BOOL finished) {
            
            [menuView removeFromSuperview];
            [maskView removeFromSuperview];
            
        }];
    }];

    
    return menuView;
}

- (void)show {
        
    [UIView animateWithDuration:1 animations:^{
        
        self.originX = 75;
        
    } completion:^(BOOL finished) {
        
        
    }];
}


//- (void)hide {
//    
//    [UIView animateWithDuration:1 animations:^{
//        
//        self.originX = ScreenWidth;
//        
//    } completion:^(BOOL finished) {
//        
//        [self removeFromSuperview];
//        
//    }];
//}
@end

@implementation MenuViewCell
//创建菜单视图上的子视图（单元格，单元格头视图）
+ (id)createFromXibWithMenuViewCell {
    
    
    
    MenuViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MenuView" owner:nil options:nil]objectAtIndex:2];
    
    return cell;

}

@end



@implementation MenuCellHeaderView

//单元格头视图点击全部按钮事件
//- (IBAction)tapAllButtonAction:(UIControl *)sender {
//    
//    NSLog(@"点击了全部按钮");
//    
//    if (self.tapAllButtonBlock) {
//        
//        
//        self.tapAllButtonBlock();
//    }
//    
//}
+ (id)createFromXibWithMenuCellHeaderView {
    
    MenuCellHeaderView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"MenuView" owner:nil options:nil]objectAtIndex:3];
    
    return headerView;
}


- (IBAction)tapAllButtonAction:(UIControl *)sender {
    
    
        NSLog(@"点击了全部按钮");
    
        if (self.tapAllButtonBlock) {
    
    
            self.tapAllButtonBlock();
        }
}

@end


