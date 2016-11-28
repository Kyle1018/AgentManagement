//
//  AMCertificationDetailViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMCertificationDetailViewController.h"

@interface AMCertificationDetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel *companyNameLable;
@property (nonatomic, weak) IBOutlet UILabel *companyIDLabel;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UIImageView *licenceImageView;
@property (nonatomic, weak) IBOutlet UIImageView *frontImageView;
@property (nonatomic, weak) IBOutlet UIImageView *backImageView;
@property (nonatomic, weak) IBOutlet UIButton *commitButton;

@end

@implementation AMCertificationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializeControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeControl {
    self.title = @"公司认证信息";
    
    self.statusLabel.layer.masksToBounds = YES;
    self.statusLabel.layer.cornerRadius = self.statusLabel.width / 2;
    self.statusLabel.layer.borderColor = [UIColor colorWithHex:@"47B6FF"].CGColor;
    self.statusLabel.layer.borderWidth = .5;
    
    self.commitButton.layer.masksToBounds = YES;
    self.commitButton.layer.cornerRadius = 4.;
    [self.commitButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"47b6ff"]] forState:UIControlStateNormal];
    
    @weakify(self);
    [[self.commitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
    }];
}

@end
