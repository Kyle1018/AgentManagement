//
//  AddProductViewControllerB.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/20.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddProductViewControllerB.h"
#import "AlertController.h"

@interface AddProductViewControllerB ()

@property(nonatomic,strong)AlertController *alertVC;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property(nonatomic,strong)UIView *maskView;
@property (weak, nonatomic) IBOutlet UITextField *inputPrice;
@property(nonatomic,strong)NSMutableSet *set;
@property(nonatomic,strong)NSMutableDictionary *optionDic;
@end

@implementation AddProductViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];

    _set = [NSMutableSet set];
    
    _optionDic = [NSMutableDictionary dictionaryWithDictionary:self.dic];
    
    [self createMaskView];
 
}

- (void)createMaskView {
    
    self.maskView = [[UIView alloc] initWithFrame:ScreenFrame];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
}

- (void)hideMyPicker {
    
    self.nextButton.enabled = [self buttonIsEnabel];
    
    if (self.inputPrice.text.length > 0) {
        
        if ([self.optionDic objectForKey:@(307)]) {
            
            [self.optionDic removeObjectForKey:@(307)];
        }
        
        [self.optionDic setObject:self.inputPrice.text forKey:@"inputPrice"];
        
    }
    
    else {
        
        [self.optionDic removeObjectForKey:@"inputPrice"];
    }
    
      UILabel *label = [self.view viewWithTag:307];
    
    if (self.inputPrice.text.length > 0) {
        
        if (label.text.length > 0) {
            
            [self.optionDic removeObjectForKey:@(307)];
            
            [self.optionDic setObject:self.inputPrice.text forKey:@"inputPrice"];
            
        }
        
        else {
            
               [self.optionDic setObject:self.inputPrice.text forKey:@"inputPrice"];
        }
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if ([self.inputPrice isFirstResponder]) {
            
            [self.inputPrice resignFirstResponder];
        }
   
        self.maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.maskView removeFromSuperview];
        
    }];
}

- (BOOL)buttonIsEnabel {
    
    UILabel *label = [self.view viewWithTag:307];
    
    if (self.inputPrice.text.length > 0) {
        
        label.text = nil;
        
        [self.set addObject:@(label.tag)];
        
        if (self.set.count == 9) {
            
            return YES;
            
        }
        else {
            
            return NO;
        }
        
    }
    
    else {
        
        
        if (!label) {
            
            if (label.text.length > 0) {
                
                return YES;
            }
            
            else {
                
                return NO;
            }
        }
        
        else {
            
            return NO;
        }
    }
}


#pragma mark -TabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;

    self.alertVC = [AlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    //点击了选项回调
    self.alertVC.tapActionButtonBlock = ^(NSInteger kTag,NSInteger index) {
        
        UILabel *label = [tableView viewWithTag:kTag];
        label.text = weakSelf.alertVC.actionButtonArray[index];
        
        [weakSelf.optionDic setObject:label.text forKey:@(kTag)];
        
        if (label.tag == 307) {
            
            weakSelf.inputPrice.text = nil;
            
            if ([weakSelf.optionDic objectForKey:@"inputPrice"]) {
                
                [weakSelf.optionDic removeObjectForKey:@"inputPrice"];
                
            }
        }
        
        [weakSelf.set addObject:@(kTag)];
        
        
        if (weakSelf.set.count == 9) {
            
            weakSelf.nextButton.enabled = YES;
        }
        else {
            
             weakSelf.nextButton.enabled = NO;
        }
        
        
           NSLog(@"%@",weakSelf.optionDic);
    };
    
 
    
 
    //直接饮用
    if (indexPath.row == 0) {
        
        self.alertVC.title = @"直接饮用";
        self.alertVC.actionButtonArray = @[@"可以",@"不可以"];
        self.alertVC.kTag = 300;
        
    }
    
    //分类
    else if (indexPath.row == 1) {
        
        self.alertVC.title = @"分类";
        self.alertVC.actionButtonArray = @[@"纯水机",@"家用净水机",@"商用净水器",@"软水机",@"管线机",@"水处理设备",@"龙头净水器",@"净水杯"];
        self.alertVC.kTag = 301;
    }
    
    //过滤介质
    else if (indexPath.row == 2 ) {
        
        self.alertVC.title = @"过滤介质";
        self.alertVC.actionButtonArray = @[@"反渗透",@"超滤",@"活性炭",@"PP棉",@"陶瓷纳滤",@"不锈钢滤网",@"微滤",@"其它"];
        self.alertVC.kTag = 302;
        
    }
    
    //产品特点
    else if (indexPath.row == 3) {
        
        self.alertVC.title = @"产品特点";
        self.alertVC.actionButtonArray = @[@"无废水",@"无桶大通量",@"双出水",@"滤芯寿命提示",@"低废水单出水",@"双模双出水",@"紫外线杀菌",@"TDS显示"];
        self.alertVC.kTag = 303;
    }
    
    //摆放位置
    else if (indexPath.row == 4) {
        
        self.alertVC.title = @"摆放位置";
        self.alertVC.actionButtonArray = @[@"厨下式",@"龙头式",@"台上式",@"滤芯寿命提示",@"低废水入户过滤",@"壁挂式",@"其它"];
        self.alertVC.kTag = 304;
    }
    
    //滤芯个数
    else if (indexPath.row == 5) {
        
        self.alertVC.title = @"滤芯个数";
        self.alertVC.actionButtonArray = @[@"1级",@"2级",@"3级",@"4级",@"5级",@"6级",@"6级以上"];
        self.alertVC.kTag = 305;
    }
    
    //适用地区
    else if (indexPath.row == 6) {
        
        self.alertVC.title = @"适用地区";
        self.alertVC.actionButtonArray = @[@"华北",@"华南",@"华东",@"华中",@"其它"];
        self.alertVC.kTag = 306;
        
    }
    
    //零售价格
    else if (indexPath.row == 7) {
        
        self.alertVC.title = @"零售价格";
        self.alertVC.actionButtonArray = @[@"0-399",@"400-999",@"1000-2199",@"2200-3799",@"其它"];
        self.alertVC.kTag = 307;
    }
    
    //手动输入——零售价格
    else if (indexPath.row == 8) {
    
        [self.alertVC removeFromParentViewController];
 
    }
    
    //换滤芯周期
    else if (indexPath.row == 9) {
        
        self.alertVC.title = @"换滤芯周期";
        self.alertVC.actionButtonArray = @[@"1个月",@"3个月",@"6个月",@"12个月",@"18个月",@"24个月"];
        self.alertVC.kTag = 308;
    }
    
    
    
    [self presentViewController: self.alertVC animated: YES completion:^{
       
        
    }];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [self.view addSubview:self.maskView];
    self.maskView.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
    }];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    self.nextButton.enabled = [self buttonIsEnabel];
    
    if (self.inputPrice.text.length > 0) {
        
        if ([self.optionDic objectForKey:@(307)]) {
            
            [self.optionDic removeObjectForKey:@(307)];
        }
        
        [self.optionDic setObject:self.inputPrice.text forKey:@"inputPrice"];
            
    }
    
    else {
        
        [self.optionDic removeObjectForKey:@"inputPrice"];
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
    [page2 setValue:self.optionDic forKey:@"dic"];
}

@end
