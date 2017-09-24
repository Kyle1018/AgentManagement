//
//  RegisterDetailViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 17/1/3.
//  Copyright © 2017年 KK. All rights reserved.
//

#import "RegisterDetailViewController.h"
#import "LandViewModel.h"
@interface RegisterDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *ep_name;
@property (weak, nonatomic) IBOutlet UITextField *ep_corp;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextView *ep_addr;
@property (weak, nonatomic) IBOutlet UILabel *ep_addrPlaceOrder;
@property (weak, nonatomic) IBOutlet UITextField *ep_saleamount;
@property (weak, nonatomic) IBOutlet UITextField *ep_brand;
@property (weak, nonatomic) IBOutlet UITextField *ep_staffnum;
@property (weak, nonatomic) IBOutlet UITextField *ep_storenum;
@property (weak, nonatomic) IBOutlet UITextField *ep_carnum;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property(nonatomic,strong)LandViewModel *viewModel;

@end

@implementation RegisterDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"填写详细信息";
    
    [self racSignal];
  
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

#pragma mark -signal
- (void)racSignal {
    
    @weakify(self);
    
    __block NSString *ep_name = @"";
    __block NSString *ep_corp = @"";
    __block NSString *phone = @"";
    __block NSString *ep_addr = @"";
    __block NSString *ep_saleamount = @"";
    __block NSString *ep_brand = @"";
    __block NSString *ep_staffnum = @"";
    __block NSString *ep_storenum = @"";
    __block NSString *ep_carnum = @"";
    
    //公司名称
    RACSignal *validLenthEp_nameSignal = [self.ep_name.rac_textSignal map:^id(NSString* value) {
        
        ep_name = value;
        return @(value.length>0);
    }];
    
    //法人名称
    RACSignal *validLenthEp_corpSignal = [self.ep_corp.rac_textSignal map:^id(NSString* value) {

        ep_corp = value;
        return @(value.length>0);
    }];
    
    //手机号
    RACSignal *validLenthPhoneSignal = [self.phone.rac_textSignal map:^id(NSString* value) {
        
        phone = value;
        return @(value.length>0);
    }];
    
    //公司地址
    RACSignal *validLenthEp_addrSignal = [self.ep_addr.rac_textSignal map:^id(NSString* value) {
        
        @strongify(self);
        
        ep_addr = value;
        
        self.ep_addrPlaceOrder.hidden=[@(value.length>0)boolValue];
        
        return @(value.length>0);
    }];
    
    
    //年销售额
    RACSignal *validLenthEp_saleamountSignal = [self.ep_saleamount.rac_textSignal map:^id(NSString* value) {
        
        ep_saleamount = value;
        
        return @(value.length>0);
    }];
    
    //经营品牌
    RACSignal *validLenthEp_brandSignal = [self.ep_brand.rac_textSignal map:^id(NSString* value) {
       
        ep_brand = value;
        
        return @(value.length>0);
    }];
    
    //公司人数
    RACSignal *validLenthEp_staffnumSignal = [self.ep_staffnum.rac_textSignal map:^id(NSString* value) {
       
        ep_staffnum = value;
        
        return @(value.length>0);
    }];
    
    
    //门店数量
    RACSignal *validLenthEp_storenumSignal = [self.ep_storenum.rac_textSignal map:^id(NSString* value) {
       
        ep_storenum = value;
        
        return @(value.length>0);
    }];
    
    //服务车辆
    RACSignal *validLenthEp_carnumSignal = [self.ep_carnum.rac_textSignal map:^id(NSString* value) {
        
        ep_carnum = value;
        
        return @(value.length>0);
    }];
    
    //所有输入框是否有内容
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validLenthEp_nameSignal,validLenthEp_corpSignal,validLenthPhoneSignal,validLenthEp_addrSignal,validLenthEp_saleamountSignal,validLenthEp_brandSignal,validLenthEp_staffnumSignal,validLenthEp_storenumSignal,validLenthEp_carnumSignal] reduce:^id(NSNumber *a,NSNumber*b,NSNumber*c,NSNumber*d,NSNumber*e,NSNumber*f,NSNumber*g,NSNumber*h,NSNumber*i){
        
        return @([a boolValue] && [b boolValue]&& [c boolValue]&& [d boolValue]&& [e boolValue]&& [f boolValue]&& [g boolValue]&& [h boolValue]&& [i boolValue]);
    }];
    
    //根据所有输入框是否都有内容——决定登录按钮是否可以点击
    RAC(self.finishBtn,enabled) = [signUpActiveSignal map:^id(NSNumber* value) {
        @strongify(self);
        self.finishBtn.backgroundColor= [value boolValue]?[UIColor colorWithHex:@"47b6ff"]:[UIColor colorWithHex:@"b3b3b3"];
        return value;
    }];
    
    
    //请求完善企业信息接口
    [[self.finishBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [[self.viewModel requestAddEPinformation:@{@"phone" : phone,
                                                  @"ep_corp" : ep_corp,
                                                  @"ep_name" : ep_name,
                                                  @"ep_saleamount" : ep_saleamount,
                                                  @"ep_brand" : ep_brand,
                                                  @"ep_addr" : ep_addr,
                                                  @"ep_storenum" : ep_storenum,
                                                  @"ep_carnum" : ep_carnum,
                                                  @"ep_staffnum" : ep_staffnum,
                                                  @"ep_tel" : phone
                                                  }] subscribeNext:^(id x) {
            AMBaseModel *model = (AMBaseModel *)x;
            
            if ([model isValid]) {
            } else {
                [MBProgressHUD showText:model.resultMessage];
            }
        }];
    }];
    
}

- (LandViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [LandViewModel new];
    }
    return _viewModel;
}

#pragma mark -tabelViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 30;
    }
    else {
        
        return 10;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    return headerView;
}

@end
