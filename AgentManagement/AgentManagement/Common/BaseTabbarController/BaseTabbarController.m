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
        
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        //vc.view.backgroundColor = [UIColor themeColor];//
        NSLog(@"%@",dict[kStoryboardKey]);
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:dict[kStoryboardKey] bundle:nil];
        BaseNavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"Nav"];
        
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:[dict[kImgKey] stringByAppendingString:@"_hl"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
    
    [self setupNavBar];
    [self setupTabBar];
   // [self setupKeyboard];
    //[NSChangyanSDK initAPP];
}

#pragma mark - Config

- (void)setupNavBar
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UINavigationBar *bar = [UINavigationBar appearance];
    CGFloat rgb = 0.1;
    bar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.9];
    bar.tintColor = [UIColor whiteColor];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationbarColor]];
    
}

- (void)setupTabBar
{
    //    // Delegate
    //    [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
    //        DTLog(@"viewWillAppear 方法被调用 %@", x);
    //    }];
    
    //    [[UITabBar appearance] setBarTintColor:[UIColor titleBarColor]];
}

//- (void)setupKeyboard
//{
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;//控制整个功能是否启用。
//    manager.shouldResignOnTouchOutside = YES;//控制点击背景是否收起键盘
//    manager.shouldToolbarUsesTextFieldTintColor = YES;//控制键盘上的工具条文字颜色是否用户自定义
//    manager.enableAutoToolbar = NO;//控制是否显示键盘上的工具条
//}


#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
//    //点击刷新当前页面
//    if (self.selectedIndex <= 1 && self.selectedIndex == [tabBar.items indexOfObject:item]) {
//        UIViewController * controllerVC = (UIViewController *)((UINavigationController *)self.selectedViewController).viewControllers[0];
//        NSBaseTableViewController *objsViewController = (NSBaseTableViewController *)controllerVC.childViewControllers[0];
//        
//        [UIView animateWithDuration:0.1 animations:^{
//            if ([objsViewController isKindOfClass:[UITableViewController class]]) {
//                [objsViewController.tableView setContentOffset:CGPointMake(0, -objsViewController.refreshControl.frame.size.height)];
//                
//            }
//        } completion:^(BOOL finished) {
//            [objsViewController.tableView.mj_header beginRefreshing];
//        }];
//        if ([objsViewController isKindOfClass:[UITableViewController class]]) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [objsViewController refresh];
//            });
//        }
//    }
}

#pragma mark - navigationItem

//- (UINavigationController *)addNavigationItemForViewController:(UIViewController *)viewController
//{
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
//    
//    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
//                                                                                                     target:self
//                                                                                                     action:@selector(pushSearchViewController)];
//    return navigationController;
//}

//- (void)pushSearchViewController
//{
//    [(UINavigationController *)self.selectedViewController pushViewController:[SearchViewController new] animated:YES];
//}


@end
