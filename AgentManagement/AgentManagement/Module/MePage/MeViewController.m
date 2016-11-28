//
//  MeViewController.m
//  AgentManagement
//
//  Created by huabin on 16/8/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "MeViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AMUpdatePasswordRequest.h"

@interface MeViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *portraitImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *subNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UIImageView *codeImageView;

@property (nonatomic, strong) AMUpdatePasswordRequest *request;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeControl];
    
    self.request = [[AMUpdatePasswordRequest alloc] initWithCurrentPassword:@"111aaa" inputPassword:@"aaa111" confirmPassword:@"aaa111"];
    [self.request requestWithSuccess:^(KKBaseModel *model, KKRequestError *error) {
        NSLog(@"fa");
    } failure:^(KKBaseModel *model, KKRequestError *error) {
        NSLog(@"fa");
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUserUI];
}

- (void)initializeControl {
    self.title = @"我的";
}

- (void)updateUserUI {
#warning 数据未正式返回
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:kSharedUserManager.user.img] placeholderImage:nil];
    self.nameLabel.text = kSharedUserManager.user.nickname;
    
    self.phoneLabel.text = nil;
    if (kSharedUserManager.user.tphone.length > 0) {
        self.phoneLabel.text = [NSString stringWithFormat:@"电话：%@", kSharedUserManager.user.tphone];
    }
    self.addressLabel.text = nil;
}

- (IBAction)administratorPressed:(id)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"AMAdministatorViewController") alloc] init] animated:YES];
}

- (IBAction)salespersonPressed:(id)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"AMSalespersonViewController") alloc] init] animated:YES];
    
}

- (IBAction)logPressed:(id)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"AMLogViewController") alloc] init] animated:YES];
}

- (IBAction)settingPressed:(id)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"AMSettingViewController") alloc] init] animated:YES];
}

- (IBAction)messagePressed:(id)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"AMMessageViewController") alloc] init] animated:YES];
}

@end
