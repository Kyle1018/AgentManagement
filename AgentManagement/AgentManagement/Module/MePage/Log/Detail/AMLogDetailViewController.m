//
//  AMLogDetailViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMLogDetailViewController.h"

@interface AMLogDetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel *operatorLabel;
@property (nonatomic, weak) IBOutlet UILabel *levelLabel;
@property (nonatomic, weak) IBOutlet UILabel *pageLable;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *positionLabel;

@end

@implementation AMLogDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeControl {
    self.title = @"日志详情";
    
    self.operatorLabel.text = nil;
    self.levelLabel.text = nil;
    self.pageLable.text = nil;
    self.timeLabel.text = nil;
    self.positionLabel.text = nil;
}

@end
