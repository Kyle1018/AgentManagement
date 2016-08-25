//
//  AddProductViewControllerC.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/21.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddProductViewControllerC.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import "ProductManageViewController.h"
//#import "DataCacheManager.h"
@interface AddProductViewControllerC ()
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextField *count;
@property(nonatomic,strong)UIView *maskView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property(nonatomic,strong)NSMutableDictionary *optionDic;
@end

@implementation AddProductViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _optionDic = [NSMutableDictionary dictionaryWithDictionary:self.dic];
    
     [self createMaskView];
    
    [self saveButtonIsEnabel];

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
    
    __weak typeof(self) weakSelf = self;
    RACSignal *priceInputSignal = [[self.price rac_textSignal]map:^id(NSString* value) {
        
        return [weakSelf isValid:value];
        
    }];
    
    RACSignal *countInputSignal = [[self.count rac_textSignal]map:^id(NSString* value) {
        
        return [weakSelf isValid:value];
        
    }];
    
    
    RACSignal *signUpActiveSignal =
    [RACSignal combineLatest:@[priceInputSignal, countInputSignal]
                      reduce:^id(NSNumber*priceInputValid, NSNumber *countInpuValid){
                          
                          return @([priceInputValid boolValue]&&[countInpuValid boolValue]);
                      }];
    
    
    RAC(self.saveButton,enabled) = signUpActiveSignal;
}

- (NSNumber*)isValid:(NSString*)text {
    
    if (text.length > 0) {
        
        return @(YES);
    }
    else {
        
        return @(NO);
    }
    
}

- (IBAction)saveAction:(UIButton *)sender {
   
//    for (UIViewController *vc in self.navigationController.viewControllers) {
//        
//        if ([vc isKindOfClass:[ProductManageViewController class]]) {
//            
//            ProductManageViewController*productManagerVC = (ProductManageViewController*)vc;
//            productManagerVC.optionResultDic = self.optionDic;
//            
//        }
//    }
    
    NSLog(@"%@",self.optionDic);
    
    //插入数据库
    [[DataCacheManager shareDataCacheManager]setInsertOrDelete:YES withType:PRODUCT_MANAGER andDic:self.optionDic];
    
    [self.navigationController popToRootViewControllerAnimated:YES];

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
        
        [_optionDic setObject:textField.text forKey:@"purchasePrice"];
    }
    
    else if (textField.tag == 102) {
        
        [_optionDic setObject:textField.text forKey:@"purchaseCount"];
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
