//
//  AddProductViewControllerA.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/14.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddProductViewControllerA.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface AddProductViewControllerA ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *brandTextField;//品牌输入
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;//型号输入
@property (weak, nonatomic) IBOutlet UIButton *nextButton;//下一步按钮
@property(nonatomic,strong)UIView *maskView;//遮罩视图
@property(nonatomic,strong)NSMutableDictionary *inputContentDic;
@end

@implementation AddProductViewControllerA

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _inputContentDic = [NSMutableDictionary dictionary];

    //下一步按钮是否允许点击处理
    [self nextButtonIsEnabel];
    
    //阴影视图
    [self createMaskView];
    

}

- (void)nextButtonIsEnabel {
    
    __weak typeof(self) weakSelf = self;
    RACSignal *brandInputSignal = [[self.brandTextField rac_textSignal]map:^id(NSString* value) {
        
        return [weakSelf isValid:value];
        
    }];
                                   
    RACSignal *modelInputSignal = [[self.modelTextField rac_textSignal]map:^id(NSString* value) {
        
        return [weakSelf isValid:value];
        
    }];
    
    
    RACSignal *signUpActiveSignal =
    [RACSignal combineLatest:@[brandInputSignal, modelInputSignal]
                      reduce:^id(NSNumber*brandInputValid, NSNumber *modelInputValid){
                          
                          return @([brandInputValid boolValue]&&[modelInputValid boolValue]);
                      }];
    
    
    RAC(weakSelf.nextButton,enabled) = signUpActiveSignal;
}

- (NSNumber*)isValid:(NSString*)text {
    
    if (text.length > 0) {
        
        return @(YES);
    }
    else {
        
        return @(NO);
    }
    
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
    
    [_inputContentDic setObject:brandTextField.text forKey:@"brandName"];
    [_inputContentDic setObject:modelTextField.text forKey:@"modelName"];


    [UIView animateWithDuration:0.3 animations:^{
        
        if ([self.brandTextField isFirstResponder]) {
            
            [self.brandTextField resignFirstResponder];
        }
        else if ([self.modelTextField isFirstResponder]) {
            
            [self.modelTextField resignFirstResponder];
        }
        self.maskView.alpha = 0;
       
    } completion:^(BOOL finished) {
        
        [self.maskView removeFromSuperview];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
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
        
        [_inputContentDic setObject:textField.text forKey:@"brandName"];
    }
    
    else if (textField.tag == 102) {
        
        [_inputContentDic setObject:textField.text forKey:@"modelName"];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [textField resignFirstResponder];
        
        self.maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.maskView removeFromSuperview];
        
    }];


    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

        id page2=segue.destinationViewController;
        [page2 setValue:_inputContentDic forKey:@"dic"];
}

@end
