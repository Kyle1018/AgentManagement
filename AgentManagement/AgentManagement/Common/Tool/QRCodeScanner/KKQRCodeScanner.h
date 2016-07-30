//
//  KKQRCodeScanner.h
//  PuRunMedical
//
//  Created by Kyle on 16/6/20.
//  Copyright © 2016年 PuRun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^ScanResultBlock)(NSString *codeString);

@interface KKQRCodeScanner : NSObject

@property (nonatomic, copy) ScanResultBlock resultBlock;

- (instancetype)initWithScannerSuperView:(UIView *)superView scanRect:(CGRect)scanRect;

- (void)startScan;
- (void)stopScan;

@end
