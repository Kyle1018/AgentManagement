//
//  AddProductViewControllerB.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/20.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AddProductViewControllerB.h"
#import "AlertController.h"
#import "ProductManageViewModel.h"
#import "AMProductRelatedInformation.h"
@interface AddProductViewControllerB ()
@property(nonatomic,strong)ProductManageViewModel *viewModel;
@property(nonatomic,strong)AlertController *alertVC;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property(nonatomic,strong)UIView *maskView;
@property (weak, nonatomic) IBOutlet UITextField *inputPrice;
@property(nonatomic,strong)NSMutableSet *set;
@property(nonatomic,strong)NSMutableDictionary *optionDic;
@property(nonatomic,strong)NSMutableArray *optionDataArray;
@property(nonatomic,strong)NSMutableArray *optionTitleDataArray;
@end

@implementation AddProductViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];

    _set = [NSMutableSet set];
    
    _optionDic = [NSMutableDictionary dictionaryWithDictionary:self.inputContentDic];

    [self getData];
 
    [self createMaskView];
}

- (void)getData {
    
    _optionTitleDataArray = [NSMutableArray arrayWithObjects:@"直接饮用",@"分类",@"过滤介质",@"产品特点",@"摆放位置",@"滤芯个数",@"使用地区",@"零售价格",@"换芯周期", nil];
   _optionDataArray = [NSMutableArray arrayWithObjects:
                             @[@"可以",@"不可以"],
                             @[@"纯水机",@"家用净水机",@"商用净水器",@"软水机",@"管线机",@"水处理设备",@"龙头净水器",@"净水杯"],
                             @[@"反渗透",@"超滤",@"活性炭",@"PP棉",@"陶瓷纳滤",@"不锈钢滤网",@"微滤",@"其它"],
                             @[@"无废水",@"无桶大通量",@"双出水",@"滤芯寿命提示",@"低废水单出水",@"双模双出水",@"紫外线杀菌",@"TDS显示"],
                             @[@"厨下式",@"龙头式",@"台上式",@"滤芯寿命提示",@"低废水入户过滤",@"壁挂式",@"其它"],
                             @[@"1级",@"2级",@"3级",@"4级",@"5级",@"6级",@"6级以上"],
                             @[@"华北",@"华南",@"华东",@"华中",@"其它"],
                             @[@"手动输入价格"],
                             @[@"1个月",@"3个月",@"6个月",@"12个月",@"18个月",@"24个月"],nil];
    
    for (AMProductRelatedInformation *model in self.productRelatedInformationArray) {
        
        if ([model.key isEqualToString:@"drinking"]) {
            
            [_optionDataArray replaceObjectAtIndex:0 withObject:model.value];
        }
        
        else if ([model.key isEqualToString:@"classification"]) {
            
            [_optionDataArray replaceObjectAtIndex:1 withObject:model.value];
        }
        else if ([model.key isEqualToString:@"filter"]) {
            
            [_optionDataArray replaceObjectAtIndex:2 withObject:model.value];
        }
        else if ([model.key isEqualToString:@"features"]) {
            
            [_optionDataArray replaceObjectAtIndex:3 withObject:model.value];
        }
        else if ([model.key isEqualToString:@"putposition"]) {
            
            [_optionDataArray replaceObjectAtIndex:4 withObject:model.value];
        }
        else if ([model.key isEqualToString:@"number"]) {
            
            [_optionDataArray replaceObjectAtIndex:5 withObject:model.value];
        }
        else if ([model.key isEqualToString:@"area"]) {
            
            [_optionDataArray replaceObjectAtIndex:6 withObject:model.value];
        }
        
        else if ([model.key isEqualToString:@"cycle"]) {
            
            [_optionDataArray replaceObjectAtIndex:8 withObject:model.value];
        }
    }

    
}

- (void)createMaskView {
    
    self.maskView = [[UIView alloc] initWithFrame:ScreenFrame];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
}

- (void)hideMyPicker {
    
    
    if (self.inputPrice.text.length > 0) {
        
        [self.set addObject:@"price"];
        
        [self.optionDic setObject:self.inputPrice.text forKey:@"price"];
        
        
    }
    else {
        
        if ([self.set containsObject:@"price"]) {
            
            [self.set removeObject:@"price"];
            
            [self.optionDic removeObjectForKey:@"price"];
        }
    }
    
    if (self.set.count == 8) {
        
        self.nextButton.enabled = YES;
    }
    else {
        
        self.nextButton.enabled = NO;
    }

    [UIView animateWithDuration:0.3 animations:^{
        
        [self.inputPrice resignFirstResponder];

        self.maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.maskView removeFromSuperview];
        
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
        
        //将key存入set集合，用于判断下一步按钮是否可以点击
        [weakSelf.set addObject:keyName];
        
        if (weakSelf.set.count == 8) {
            
            weakSelf.nextButton.enabled = YES;
        }
        else {
            
             weakSelf.nextButton.enabled = NO;
        }
     };
    
    
    //如果是手动输入零售价格单元格，则不显示alert
    if (indexPath.row == 7) {
        
        [self.alertVC removeFromParentViewController];

    }
    else {
        
        self.alertVC.title = self.optionTitleDataArray[indexPath.row];

        self.alertVC.actionButtonArray = self.optionDataArray[indexPath.row];
        
        self.alertVC.alertTag = indexPath.row + 300;

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

    if (textField.text.length > 0) {
        
        [self.set addObject:@"price"];
      
        [self.optionDic setObject:textField.text forKey:@"price"];


    }
    else {
        
        if ([self.set containsObject:@"price"]) {
            
            [self.set removeObject:@"price"];
            
            [self.optionDic removeObjectForKey:@"price"];
        }
    }
    
    if (self.set.count == 8) {
        
        self.nextButton.enabled = YES;
    }
    else {
        
        self.nextButton.enabled = NO;
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
    [page2 setValue:self.optionDic forKey:@"inputContentDic"];
}

@end
