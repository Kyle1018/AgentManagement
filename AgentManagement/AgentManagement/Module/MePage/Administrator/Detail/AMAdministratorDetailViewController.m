//
//  AMAdministratorDetailViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMAdministratorDetailViewController.h"

NSString *const kAdministratorAreaDefaultString = @"所属区域";

@interface AMAdministratorDetailViewController ()

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UILabel *arearLabel;
@property (nonatomic, weak) IBOutlet UIButton *arearButton;

@end

@implementation AMAdministratorDetailViewController

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
    self.title = self.administrator ? @"管理员详情" : @"添加管理员";
    
    [self initializeNavigation];
    
    self.nameTextField.text = self.administrator.nickname;
    self.phoneTextField.text = self.administrator.username;
    [self updateArea:self.administrator.area];
    @weakify(self);
    [[self.arearButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
    }];
    
    RAC(self.arearButton, enabled) = [RACSignal combineLatest:@[[self.nameTextField rac_textSignal], [self.phoneTextField rac_textSignal], RACObserve(self.arearLabel, text)] reduce:^id(NSString *name, NSString *phone, NSString *area) {
        return @((name.length > 0) && (phone.length > 0) && ![area isEqualToString:kAdministratorAreaDefaultString]);
    }];
}

- (void)initializeNavigation {
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveItemPressed)];
    
    self.navigationController.navigationItem.rightBarButtonItem = saveItem;
}

- (void)updateArea:(NSString *)area {
    self.arearLabel.text = ((area.length > 0) ? area : kAdministratorAreaDefaultString);
    self.arearLabel.textColor = ((area.length > 0) ? [UIColor colorWithHex:@"4a4a4a"] : [UIColor colorWithHex:@"9b9b9b"]);
}

- (void)saveItemPressed {
    if (self.administrator) {   // 修改
    } else {    // 添加
    }
}

@end
