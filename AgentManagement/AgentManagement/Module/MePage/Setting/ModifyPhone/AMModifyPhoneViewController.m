//
//  AMModifyPhoneViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMModifyPhoneViewController.h"

@interface AMModifyPhoneViewController ()

@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;

@end

@implementation AMModifyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeControl {
    self.title = @"电话";
    
   // self.phoneTextField.text = kSharedUserManager.user.tphone;
}

@end
