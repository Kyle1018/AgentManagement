//
//  AppDelegate.m
//  AgentManagement
//
//  Created by Kyle on 16/7/25.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AMRegisterRequest.h"
//#import "AMRegistRequest.h"
@interface AppDelegate ()

@property(nonatomic,strong)AMRegisterRequest *registerRequest;
//@property(nonatomic,strong)AMRegistRequest *registRequest;

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

//
//    
//    self.registerRequest = [[AMRegisterRequest alloc]initWithPhone:@"13426090573" Password:@"abcd1234" Code:@"544713"];
//    
//    [self.registerRequest requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
//        
//        NSLog(@"%@",model);
//        
//        NSLog(@"%@",error);
//        
//    } failure:^(KKBaseModel *model, KKRequestError *error) {
//       
//        
//        NSLog(@"%@",model);
//        
//        NSLog(@"%@",error);
//    }];
//    
    

    
    
    

   // NSLog(@"%@",code);
    
    return YES;
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
