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
    
    
    RAC(self.saveButton,enabled) = signUpActiveSignal;
}

- (IBAction)saveAction:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;

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
   
        for(UIViewController*vc in self.navigationController.viewControllers){
            
            if([vc isKindOfClass:[ProductManageViewController class]]){
                
              ProductManageViewController*oneVC =(ProductManageViewController*)vc;
                
                oneVC.productInfo=x;
                
                [weakSelf.navigationController popToViewController:oneVC animated:YES];}
        }
        
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    __weak typeof(self) weakSelf = self;
    
    MaskView *maskView=[MaskView showAddTo:self.view];
    
    maskView.hideMaskViewBlock = ^() {
        
        [weakSelf.optionDic setObject:weakSelf.price.text forKey:@"stock_price"];
        [weakSelf.optionDic setObject:weakSelf.count.text forKey:@"stock_number"];
        
        [textField resignFirstResponder];
    };
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 101) {
        
        [_optionDic setObject:textField.text forKey:@"stock_price"];
    }
    
    else if (textField.tag == 102) {
        
        [_optionDic setObject:textField.text forKey:@"stock_number"];
    }
    
    
    [textField resignFirstResponder];
    [MaskView hideRemoveTo:self.view];

    return YES;
}

@end
