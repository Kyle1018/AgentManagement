//
//  AddProductViewControllerC.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/21.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddProductViewControllerC.h"
#import "ProductManageViewModel.h"
#import "AMProductInfo.h"
#import "ProductManageViewController.h"
@interface AddProductViewControllerC ()

@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextField *count;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property(nonatomic,strong)NSMutableDictionary *optionDic;
@property(nonatomic,strong)ProductManageViewModel *viewModel;
@end

@implementation AddProductViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _optionDic = [NSMutableDictionary dictionaryWithDictionary:self.inputContentDic];

    _viewModel =[[ProductManageViewModel alloc]init];
    
    [self signal];
}

- (void)signal {

    RACSignal *priceInputSignal = [[self.price rac_textSignal]map:^id(NSString* value) {
        
        return @(value.length>0);
        
    }];
    
    RACSignal *countInputSignal = [[self.count rac_textSignal]map:^id(NSString* value) {
        
        return @(value.length>0);
        
    }];
    
    
    RACSignal *signUpActiveSignal =
    [RACSignal combineLatest:@[priceInputSignal, countInputSignal]
                      reduce:^id(NSNumber*priceInputValid, NSNumber *countInpuValid){
                          
                          return @([priceInputValid boolValue]&&[countInpuValid boolValue]);
                      }];
    
    
    RAC(self.saveButton,enabled) = [signUpActiveSignal map:^id(id value) {
        
        if ([value boolValue]) {
            
            [self.saveButton setTitleColor:[UIColor colorWithHex:@"47b6ff"] forState:UIControlStateNormal];
            
        }
        else {
            
            [self.saveButton setTitleColor:[UIColor colorWithHex:@"9b9b9b"] forState:UIControlStateNormal];
            
        }
        
        return value;
    }];
    
    
    [[[self.price rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString* x) {
        
          [self.optionDic setObject:x forKey:@"stock_price"];
    }];
    
    [[[self.count rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString* x) {
        
          [self.optionDic setObject:x forKey:@"stock_number"];
    }];
}

- (IBAction)saveAction:(UIButton *)sender {
    
    //添加产品请求
    [[[self.viewModel requstAddProductData:self.optionDic]filter:^BOOL(id value) {
        
        if ([value isKindOfClass:[AMProductInfo class]]) {
            
            return YES;
        }
        else {
            
            [MBProgressHUD showText:@"添加产品失败"];
            return NO;
        }
        
    }]subscribeNext:^(AMProductInfo* x) {
        
        
      //  [[NSNotificationCenter defaultCenter]postNotificationName:KAddProductInfoNotifi object:nil userInfo:@{@"productInfo":x}];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];

    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section ==0) {
        
        self.price.enabled = YES;
        [self.price becomeFirstResponder];
    }
    else {
        
        self.count.enabled = YES;
        [self.count becomeFirstResponder];
    }
}

@end
