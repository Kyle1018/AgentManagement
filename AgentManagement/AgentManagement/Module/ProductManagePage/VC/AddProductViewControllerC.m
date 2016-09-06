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
@property(nonatomic,strong)UIView *maskView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property(nonatomic,strong)NSMutableDictionary *optionDic;
@property(nonatomic,strong)ProductManageViewModel *viewModel;
@end

@implementation AddProductViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _optionDic = [NSMutableDictionary dictionaryWithDictionary:self.inputContentDic];
    
     [self createMaskView];
    
    [self saveButtonIsEnabel];
    
    [self requsetData];

}

- (void)createMaskView {
    
    self.maskView = [[UIView alloc] initWithFrame:ScreenFrame];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
}

- (void)hideMyPicker {
    
    UITextField *brandTextField = [self.view viewWithTag:101];
    
    UITextField*modelTextField = [self.view viewWithTag:102];
    
    [_optionDic setObject:brandTextField.text forKey:@"purchasePrice"];
    [_optionDic setObject:modelTextField.text forKey:@"purchaseCount"];

    
    [UIView animateWithDuration:0.3 animations:^{
        
        if ([self.price isFirstResponder]) {
            
            [self.price resignFirstResponder];
        }
        else if ([self.count isFirstResponder]) {
            
            [self.count resignFirstResponder];
        }
        
        self.maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.maskView removeFromSuperview];
        
    }];
}

- (void)saveButtonIsEnabel {

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

- (void)requsetData {
    
    _viewModel = [[ProductManageViewModel alloc]init];
    
//    [[_viewModel requstAddProductData:nil]subscribeNext:^(id x) {
//       
//        
//    }];
    
}



- (IBAction)saveAction:(UIButton *)sender {
    
    NSLog(@"%@",self.optionDic);
    
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
        
        NSLog(@"%@",self.navigationController.viewControllers);
        
        for(UIViewController*vc in self.navigationController.viewControllers){
            
            if([vc isKindOfClass:[ProductManageViewController class]]){
                
              ProductManageViewController*oneVC =(ProductManageViewController*)vc;
                
                oneVC.productInfo=x;
                
                [weakSelf.navigationController popToViewController:oneVC animated:YES];}
        }
        
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [self.view addSubview:self.maskView];
    self.maskView.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
    }];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 101) {
        
        [_optionDic setObject:textField.text forKey:@"stock_price"];
    }
    
    else if (textField.tag == 102) {
        
        [_optionDic setObject:textField.text forKey:@"stock_number"];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if ([self.price isFirstResponder]) {
            
            [self.price resignFirstResponder];
        }
        else if ([self.count isFirstResponder]) {
            
            [self.count resignFirstResponder];
        }
        
        self.maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.maskView removeFromSuperview];
        
    }];

    return YES;
}

@end
