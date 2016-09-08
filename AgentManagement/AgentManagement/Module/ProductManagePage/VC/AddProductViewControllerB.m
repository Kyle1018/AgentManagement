//
//  AddProductViewControllerB.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/20.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddProductViewControllerB.h"
#import "ProductManageViewModel.h"
#import "AddProductViewControllerC.h"
@interface AddProductViewControllerB ()
@property(nonatomic,strong)ProductManageViewModel *viewModel;
@property(nonatomic,strong)AlertController *alertVC;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *inputPrice;
@property(nonatomic,strong)NSMutableDictionary *optionDic;//产品分类信息字典
@end

@implementation AddProductViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];

    _optionDic = [NSMutableDictionary dictionaryWithDictionary:self.inputContentDic];
    
    [self signal];
}

- (void)signal {
    
    __weak typeof(self) weakSelf = self;
    
    //零售价格输入
    [[[self.inputPrice rac_textSignal]distinctUntilChanged]subscribeNext:^(NSString* x) {

        [weakSelf.optionDic setObject:x forKey:@"price"];
            
    }];
    
    //下一步按钮是否可点击显示的文字颜色
    RACSignal*validSignal=[[self.inputPrice rac_textSignal]map:^id(NSString* value) {
        
        return @(value.length>0 && weakSelf.optionDic.count == 11);
    }];
    
    RAC(self.nextButton.titleLabel,textColor) =[validSignal map:^id(NSNumber* value) {
        
        return [value boolValue]?[UIColor colorWithHex:@"47b6ff"]:[UIColor colorWithHex:@"9b9b9b"];
    }];
    
    //下一步按钮点击事件
    [[[self.nextButton rac_signalForControlEvents:UIControlEventTouchUpInside]filter:^BOOL(id value) {
        
        if (weakSelf.optionDic.count == 11) {
            
            return YES;
        }
        else {
            
            return NO;
        }
        
    }]subscribeNext:^(id x) {
        
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"ProductManage" bundle:nil];
        AddProductViewControllerC *vc = [storyboard instantiateViewControllerWithIdentifier:@"AddProductCID"];
        vc.inputContentDic = weakSelf.optionDic;
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];

}

#pragma mark -TabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;

    self.alertVC = [AlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
   // 点击了选项回调
    self.alertVC.tapActionButtonBlock = ^(NSInteger alertTag,NSString* keyName,NSInteger index) {
        
        //根据tag取出对应的label
        UILabel *label = [tableView viewWithTag:alertTag];
        
        //根据点击的下标获取label的内容
        label.text = weakSelf.alertVC.actionButtonArray[index];
    
        //将取出的label内容及key存入字典，用于之后的添加产品请求参数
        [weakSelf.optionDic setObject:label.text forKey:keyName];
        
        if (weakSelf.optionDic.count == 11) {
            
            [weakSelf.nextButton setTitleColor:[UIColor colorWithHex:@"47b6ff"] forState:UIControlStateNormal];
        }
        else {
            
            [weakSelf.nextButton setTitleColor:[UIColor colorWithHex:@"9b9b9b"] forState:UIControlStateNormal];
        }
        
     };
    
    
    //如果是手动输入零售价格单元格，则不显示alert
    if (indexPath.row == 7) {
        
        [self.alertVC removeFromParentViewController];

    }
    else {
        
        [self.inputPrice resignFirstResponder];
        
        self.alertVC.title = [[self.productRelatedInformationArray firstObject]objectAtIndex:indexPath.row];

        self.alertVC.actionButtonArray = [[self.productRelatedInformationArray lastObject]objectAtIndex:indexPath.row];
        
        self.alertVC.alertTag = indexPath.row + 300;

        [self presentViewController: self.alertVC animated: YES completion:nil];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
