//
//  AMSalespersonDetailViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMSalespersonDetailViewController.h"

NSString *const kAreaDefaultString = @"所属区域";

@interface AMSalespersonDetailViewController ()

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UILabel *arearLabel;
@property (nonatomic, weak) IBOutlet UIButton *arearButton;

@end

@implementation AMSalespersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeControl {
    self.title = self.sales ? @"销售员详情" : @"添加销售员";
    
    [self initializeNavigation];
    
    self.nameTextField.text = self.sales.name;
    self.phoneTextField.text = self.sales.phone;
    [self updateArea:self.sales.area];
    @weakify(self);
    [[self.arearButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
    }];
    
    RAC(self.arearButton, enabled) = [RACSignal combineLatest:@[[self.nameTextField rac_textSignal], [self.phoneTextField rac_textSignal], RACObserve(self.arearLabel, text)] reduce:^id(NSString *name, NSString *phone, NSString *area) {
        return @((name.length > 0) && (phone.length > 0) && ![area isEqualToString:kAreaDefaultString]);
    }];
}

- (void)initializeNavigation {
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveItemPressed)];
    
    self.navigationController.navigationItem.rightBarButtonItem = saveItem;
}

- (void)updateArea:(NSString *)area {
    self.arearLabel.text = ((area.length > 0) ? area : kAreaDefaultString);
    self.arearLabel.textColor = ((area.length > 0) ? [UIColor colorWithHex:@"4a4a4a"] : [UIColor colorWithHex:@"9b9b9b"]);
}

- (void)saveItemPressed {
    if (self.sales) {   // 修改
    } else {    // 添加
    }
}

@end
