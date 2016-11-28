//
//  AMModifyNameViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMModifyNameViewController.h"

@interface AMModifyNameViewController ()

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;

@end

@implementation AMModifyNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeControl {
    self.title = @"名字";
    
    self.nameTextField.text = kSharedUserManager.user.nickname;
}

@end
