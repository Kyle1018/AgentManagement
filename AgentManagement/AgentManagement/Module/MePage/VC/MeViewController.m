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
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UIImageView *codeImageView;

@end

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeControl];
}

- (void)initializeControl
{
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = nil;
    self.phoneLabel.text = nil;
    self.addressLabel.text = nil;
    [self.codeImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
}

@end
