//
//  AMModifyAddressViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMModifyAddressViewController.h"
#import "AMUserViewModel.h"

@interface AMModifyAddressViewController ()

@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UIButton *addressButton;
@property (nonatomic, weak) IBOutlet UILabel *detailPlaceholderLabel;
@property (nonatomic, weak) IBOutlet UITextView *detailTextView;

@property (nonatomic, strong) AMUserViewModel *userViewModel;

@end

@implementation AMModifyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializeControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AMUserViewModel *)userViewModel {
    if (!_userViewModel) {
        _userViewModel = [[AMUserViewModel alloc] init];
    }
    return _userViewModel;
}

- (void)initializeControl {
    self.title = @"地址";
    
    @weakify(self);
    [[self.addressButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
    }];
    
    [self.detailTextView.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        NSString *text = x;
        
        self.detailPlaceholderLabel.hidden = (text.length > 0);
    }];
}

@end
