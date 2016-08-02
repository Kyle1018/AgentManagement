//
//  BaseTabbarController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"

#define kClassKey        @"rootVCClassString"
#define kTitleKey        @"title"
#define kStoryboardKey   @"storyboard"
#define kImgKey          @"imageName"
#define kSelImgKey       @"selectedImageName"

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *childItemsArray = @[
                                 @{kClassKey      : @"ProductManageViewController",
                                   kTitleKey      : @"产品管理",
                                   kStoryboardKey : @"ProductManage",
                                   kImgKey        : @"",
                                   kSelImgKey     : @""},
                                 
                                 @{kClassKey      : @"CustomerManageViewController",
                                   kTitleKey      : @"客户管理",
                                   kStoryboardKey : @"CustomerManage",
                                   kImgKey        : @"",
                                   kSelImgKey     : @""},
                                 
                                 @{kClassKey      : @"CostManageViewViewController",
                                   kTitleKey      : @"成本管理",
                                   kStoryboardKey : @"CostManage",
                                   kImgKey        : @"",
                                   kSelImgKey     : @""},
                                 
                                 @{kClassKey      : @"DataAnalysisViewController",
                                   kTitleKey      : @"数据分析",
                                   kStoryboardKey : @"DataAnalysis",
                                   kImgKey        : @"",
                                   kSelImgKey     : @""},
                                 
                                 @{kClassKey      : @"MeViewController",
                                   kTitleKey      : @"数据分析",
                                   kStoryboardKey : @"Me",
                                   kImgKey        : @"",
                                   kSelImgKey     : @""},
                            ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:dict[kStoryboardKey] bundle:nil];
        BaseNavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"Nav"];
        
        
        UITabBarItem *item = nav.tabBarItem;
        
        item.title = dict[kTitleKey];
        
        item.image = [UIImage imageNamed:dict[kImgKey]];
        
        item.selectedImage = [[UIImage imageNamed:[dict[kImgKey] stringByAppendingString:@"_hl"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} forState:UIControlStateSelected];
        
        [self addChildViewController:nav];
    }];
    
    //[self setupNavBar];

}

#pragma mark - Config

- (void)setupNavBar
{
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    
//    UINavigationBar *bar = [UINavigationBar appearance];
//    CGFloat rgb = 0.1;
//    bar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.9];
//    bar.tintColor = [UIColor whiteColor];
//    bar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
}







@end
