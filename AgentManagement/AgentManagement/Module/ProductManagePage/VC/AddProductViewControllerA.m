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
    
    [[[self.brandTextField rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString* x) {
       
        [self.inputContentDic setObject:x forKey:@"brand"];
    }];
    
    [[[self.modelTextField rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString* x) {
        
        [self.inputContentDic setObject:x forKey:@"pmodel"];

    }];

    RAC(self.nextButton,enabled) = [signUpActiveSignal map:^id(id value) {
        
        if ([value boolValue]) {
            
            [self.nextButton setTitleColor:[UIColor colorWithHex:@"47b6ff"] forState:UIControlStateNormal];
            
        }
        else {
            
            [self.nextButton setTitleColor:[UIColor colorWithHex:@"9b9b9b"] forState:UIControlStateNormal];
            
        }
        
        return value;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
  
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier compare:@"AddProductSegueB"]==NO) {
        
        id page2=segue.destinationViewController;
        
        [page2 setValue:self.productRelatedInformationArray forKey:@"productRelatedInformationArray"];//产品属性信息
        [page2 setValue:self.inputContentDic forKey:@"inputContentDic"];//用户输入的信息
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section ==0) {
        
        self.brandTextField.enabled = YES;
        [self.brandTextField becomeFirstResponder];
    }
    else {
        
        self.modelTextField.enabled = YES;
        [self.modelTextField becomeFirstResponder];
    }
    
}



@end
