//
//  MeViewController.m
//  AgentManagement
//
//  Created by huabin on 16/8/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "MeViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MeViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *portraitImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *subNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UIImageView *codeImageView;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeControl];
}

- (void)initializeControl {
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

@end
