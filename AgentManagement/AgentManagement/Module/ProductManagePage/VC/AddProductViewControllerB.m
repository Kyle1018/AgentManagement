//
//  AddProductViewControllerB.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/20.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddProductViewControllerB.h"
#import "ProductManageViewModel.h"

@interface AddProductViewControllerB ()
@property(nonatomic,strong)ProductManageViewModel *viewModel;
@property(nonatomic,strong)AlertController *alertVC;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *inputPrice;
@property(nonatomic,strong)NSMutableDictionary *optionDic;//产品分类信息字典
@property(nonatomic,strong)NSMutableSet *set;
@end

@implementation AddProductViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];

    _optionDic = [NSMutableDictionary dictionaryWithDictionary:self.inputContentDic];
    _set = [NSMutableSet set];
    
    [self signal];
}

- (void)signal {
    
    //零售价格输入
    [[[self.inputPrice rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString* x) {
        
        [self.optionDic setObject:x forKey:@"price"];
            
    }];
    
    RAC(self.nextButton,enabled) = [[self.inputPrice rac_textSignal] map:^id(NSString* value) {
        
        if (value.length>0 && self.set.count==8) {
            
            [self.nextButton setTitleColor:[UIColor colorWithHex:@"47b6ff"] forState:UIControlStateNormal];
            
            return @(YES);
        }
        else {
            
             [self.nextButton setTitleColor:[UIColor colorWithHex:@"9b9b9b"] forState:UIControlStateNormal];
            return @(NO);
        }
    }];
    
    


}

#pragma mark -TabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 7) {
        
        self.inputPrice.enabled = YES;
        [self.inputPrice becomeFirstResponder];
        [self.alertVC removeFromParentViewController];
    }
    else {
        
        self.inputPrice.enabled = NO;
        [self.inputPrice resignFirstResponder];
        
        self.alertVC = [AlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        self.alertVC.title = [[self.productRelatedInformationArray firstObject]objectAtIndex:indexPath.row+2];
        
        self.alertVC.actionButtonArray = [[self.productRelatedInformationArray lastObject]objectAtIndex:indexPath.row+2];
        
        self.alertVC.alertTag = indexPath.row + 300;
        
        [self presentViewController: self.alertVC animated: YES completion:nil];
        @weakify(self);
        // 点击了选项回调
        self.alertVC.tapActionButtonBlock = ^(NSInteger alertTag,NSString* keyName,NSInteger index) {
            
            @strongify(self);
   
            [self.set addObject:@(alertTag)];
            
            //根据tag取出对应的label
            UILabel *label = [tableView viewWithTag:alertTag];
            
            //根据点击的下标获取label的内容
            label.text = self.alertVC.actionButtonArray[index];
            
            //将取出的label内容及key存入字典，用于之后的添加产品请求参数
            [self.optionDic setObject:label.text forKey:keyName];
            
            if (self.inputPrice.text.length>0 && self.set.count==8) {
                
                self.nextButton.enabled = YES;
                [self.nextButton setTitleColor:[UIColor colorWithHex:@"47b6ff"] forState:UIControlStateNormal];

            }
            else {
                
                [self.nextButton setTitleColor:[UIColor colorWithHex:@"9b9b9b"] forState:UIControlStateNormal];
                self.nextButton.enabled = NO;
            }
 
        };
    }
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier compare:@"AddProductSegueC"]==NO) {
        
        id page2=segue.destinationViewController;
        
        [page2 setValue:self.optionDic forKey:@"inputContentDic"];//用户输入的信息
        
    }
}

@end
