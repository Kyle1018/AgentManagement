//
//  KKAppUtility.m
//  PuRunMedical
//
//  Created by Kyle on 16/7/17.
//  Copyright © 2016年 PuRun. All rights reserved.
//

#import "KKAppUtility.h"

@implementation KKAppUtility

+ (NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

+ (NSString *)appName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

@end
