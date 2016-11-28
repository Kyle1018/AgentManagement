//
//  AMCertificationViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMCertificationViewController.h"

typedef NS_ENUM(NSUInteger, AMCertificationViewType) {
    AMCertificationViewType_Licence = 0,
    AMCertificationViewType_Front,
    AMCertificationViewType_Back,
};

@interface AMCertificationViewController ()

@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIView *frontView;
@property (nonatomic, strong) IBOutlet UIImageView *frontImageView;
@property (nonatomic, strong) IBOutlet UIButton *frontButton;
@property (nonatomic, strong) IBOutlet UIView *backView;
@property (nonatomic, strong) IBOutlet UIImageView *backImageView;
@property (nonatomic, strong) IBOutlet UIButton *backButton;
@property (nonatomic, strong) IBOutlet UIView *licenceView;
@property (nonatomic, strong) IBOutlet UILabel *companyNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *companyIDLabel;
@property (nonatomic, strong) IBOutlet UIImageView *licenceImageView;
@property (nonatomic, strong) IBOutlet UIButton *licenceButton;

@end

@implementation AMCertificationViewController

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
    [self buildRightNavigationItemWithTitle:@"下一步"];
    
    [self initializeAppearanceWithButton:self.frontButton];
    [self initializeAppearanceWithButton:self.backButton];
    [self initializeAppearanceWithButton:self.licenceButton];
    
    [self showViewWithType:AMCertificationViewType_Licence];
    
    RAC(self.licenceButton, enabled) = [RACSignal combineLatest:@[RACObserve(self.licenceImageView, image)] reduce:^id(UIImage *image) {
        return @(image != nil);
    }];
    
    RAC(self.frontButton, enabled) = [RACSignal combineLatest:@[RACObserve(self.frontImageView, image)] reduce:^id(UIImage *image) {
        return @(image != nil);
    }];
    
    RAC(self.backButton, enabled) = [RACSignal combineLatest:@[RACObserve(self.backImageView, image)] reduce:^id(UIImage *image) {
        return @(image != nil);
    }];
    
    @weakify(self);
    [[self.frontButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self showViewWithType:AMCertificationViewType_Back];
    }];
    
    [[self.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self buildRightNavigationItemWithTitle:@"保存"];
    }];
    
    [[self.licenceButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self showViewWithType:AMCertificationViewType_Front];
    }];
}

- (void)buildRightNavigationItemWithTitle:(NSString *)title {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightNavigationItemPressed)];
    
    self.navigationController.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightNavigationItemPressed {
    
}

- (void)initializeAppearanceWithButton:(UIButton *)button {
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4.;
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:@"47b6ff"]] forState:UIControlStateNormal];
}

- (void)showViewWithType:(AMCertificationViewType)type {
    self.licenceView.hidden = (type != AMCertificationViewType_Licence);
    self.frontView.hidden = (type != AMCertificationViewType_Front);
    self.backView.hidden = (type != AMCertificationViewType_Back);
}

@end
