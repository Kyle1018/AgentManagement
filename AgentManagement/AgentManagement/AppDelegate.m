//
//  AppDelegate.m
//  AgentManagement
//
//  Created by Kyle on 16/7/25.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"

@interface AppDelegate ()

@property (nonatomic, retain) Reachability *notifyReachability;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *s= [UIStoryboard storyboardWithName:@"Land" bundle:nil];
    
    UINavigationController *navi = [s instantiateViewControllerWithIdentifier:@"NaviVC"];
    
    self.window.rootViewController = navi;
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    // 联网监听
    [self startNetworkNotify];
    
    return YES;
}

- (void)startNetworkNotify {
    
    if (!self.notifyReachability) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChangedNotification:) name:kReachabilityChangedNotification object:nil];
        
        self.notifyReachability = [Reachability reachabilityForInternetConnection];
        [self.notifyReachability startNotifier];
    }
}

- (void)reachabilityChangedNotification:(NSNotification *)notification {
    
    Reachability *notifyReachability = [notification object];
    
    if (notifyReachability) {
        NetworkStatus status = [notifyReachability currentReachabilityStatus];
        
        switch (status) {
            case NotReachable: {
                
                [MBProgressHUD showText:@"当前没有网络"];
               // ToastViewMessage(NSLocalizedString(@"Network unreachable string", nil));
                break;
            } case ReachableViaWWAN: {
                
              
//                _isChangeToWWAN = YES;
//        //        [[VideoDownloader downloader] resumeCurrentDownloadQueue];
//                
//                if ([VideoDownloader downloader].downloadingCount>0) {
//                    // 暂停所有下载
//                    [[VideoDownloader downloader] pauseAllDownload];
//                    //                    if (!self.netWarn) {
//                    //                        NetWarnView * newWarnView=[[NetWarnView alloc]initWithNibName:nil Frame:[UIApplication sharedApplication].keyWindow.frame];
//                    NetWarnView * newWarnView = [NetWarnView loadFromXibWithNibName:nil Frame:[UIApplication sharedApplication].keyWindow.frame];
//                    self.netWarn=newWarnView;
//                    //                    }
//                    
//                    [[UIApplication sharedApplication].keyWindow addSubview:self.netWarn];
//                    self.netWarn.isShowNetWarn = YES;
                
               // }
                
               // [self promotWWAN];
                break;
            }
            
            case ReachableViaWiFi: {
                
                  [MBProgressHUD showText:@"当前处于wifi"];
                
//                if (self.netWarn && self.netWarn.isShowNetWarn) {
//                    [self.netWarn cancel];
//                }
//                
//                NSArray *arry=[NSArray arrayWithArray:[Config getVideoFromWifiDownLoadForKey:@"kWifiVideoArray"]];
//                
//                if (arry) {
//                    
//                    for (NSNumber  *videoId in arry) {
//                        [[VideoDownloader downloader] resumeDownloadVideo:[videoId intValue]];
//                    }
//                }
//                
                break;
            } default:
                break;
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
