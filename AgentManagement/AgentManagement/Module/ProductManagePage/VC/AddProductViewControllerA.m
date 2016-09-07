//
//  AddProductViewControllerA.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/14.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddProductViewControllerA.h"

@interface AddProductViewControllerA ()

@property (weak, nonatomic) IBOutlet UITextField *brandTextField;//品牌输入
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;//型号输入
@property (weak, nonatomic) IBOutlet UIButton *nextButton;//下一步按钮
@property(nonatomic,strong)NSMutableDictionary *inputContentDic;
@end

@implementation AddProductViewControllerA

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _inputContentDic = [NSMutableDictionary dictionary];
    
    //下一步按钮是否允许点击处理
    [self signal];

}

- (void)signal {
    
    __weak typeof(self) weakSelf = self;
    
    RACSignal *brandInputSignal = [[self.brandTextField rac_textSignal]map:^id(NSString* value) {
        
        return @(value.length>0);
        
    }];
                                   
    RACSignal *modelInputSignal = [[self.modelTextField rac_textSignal]map:^id(NSString* value) {
        
        return @(value.length>0);
        
    }];
    
    
    RACSignal *signUpActiveSignal =
    [RACSignal combineLatest:@[brandInputSignal, modelInputSignal]
                      reduce:^id(NSNumber*brandInputValid, NSNumber *modelInputValid){
                          
                          return @([brandInputValid boolValue]&&[modelInputValid boolValue]);
                      }];
    
    
    RAC(weakSelf.nextButton,enabled) = signUpActiveSignal;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    __weak typeof(self) weakSelf = self;
    
    MaskView *maskView=[MaskView showAddTo:self.view];
    
    maskView.hideMaskViewBlock = ^() {
        
        [weakSelf.inputContentDic setObject:self.brandTextField.text forKey:@"brand"];
        [weakSelf.inputContentDic setObject:self.modelTextField.text forKey:@"model"];
        
        [textField resignFirstResponder];
    };

    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 101) {
        
        [_inputContentDic setObject:textField.text forKey:@"brand"];
    }
    
    else if (textField.tag == 102) {
        
        [_inputContentDic setObject:textField.text forKey:@"model"];
    }
    
    [textField resignFirstResponder];
    [MaskView hideRemoveTo:self.view];

    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier compare:@"AddProductSegueB"]==NO) {
        
        id page2=segue.destinationViewController;
        [page2 setValue:self.productRelatedInformationArray forKey:@"productRelatedInformationArray"];
        [page2 setValue:self.inputContentDic forKey:@"inputContentDic"];
        
    }
}

@end
