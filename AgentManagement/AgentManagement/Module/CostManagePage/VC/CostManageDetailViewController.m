//
//  CostManageDetailViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/31.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CostManageDetailViewController.h"
#import "ProductManageViewModel.h"
@interface CostManageDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *addTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *markTextView;
@property (weak, nonatomic) IBOutlet UILabel *pmodelLabel;
@property(nonatomic,strong)AlertController *alertVC;
@property(nonatomic,strong)ProductManageViewModel *viewModel;

@end

@implementation CostManageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setData];
    
    [self signal];
}

- (void)setData {
    
    self.brandLabel.text = self.productInfo.brand;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    //    [dateFormatter setDateFormat:@"yyyy-MM"];
    self.addTimeLabel.text =  [NSString timeTransformString:self.productInfo.add_time dateFormatter:dateFormatter];
    
    self.pmodelLabel.text = self.productInfo.pmodel;
    
    self.numberLabel.text = self.productInfo.stock_number;
    
    self.stockPriceLabel.text = self.productInfo.stock_price;
    
    self.totalLabel.text = [NSString stringWithFormat:@"%ld",[self.productInfo.stock_number integerValue]*[self.productInfo.stock_price integerValue]];
    
    self.priceLabel.text = self.productInfo.price;
    
}

- (void)signal {
    
    [[[self.markTextView rac_textSignal]filter:^BOOL(NSString* value) {
        
        if (value.length>50) {
            
            [MBProgressHUD showText:@"备注可输入内容限制50字"];
            
            return NO;
        }
        else {
            
            return YES;
        }
        
    }]subscribeNext:^(NSString* x) {
        
        
    }];
}

#pragma mark -UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark-Action

- (IBAction)deleteAction:(UIButton *)sender {
    
    self.alertVC = [AlertController alertControllerWithTitle:@"确认删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
    self.alertVC.alertOptionName = @[@"删除",@"取消"];
    [self presentViewController: self.alertVC animated: YES completion:nil];
    
    _viewModel = [[ProductManageViewModel alloc]init];

    //点击了删除产品
    @weakify(self);
    self.alertVC.tapExitButtonBlock = ^() {
        
        @strongify(self);
      
        NSDictionary *dic = [self.productInfo toDictionary];
        //删除请求
        [[self.viewModel deleteProduct:dic]subscribeNext:^(NSNumber* x) {

            [self.navigationController popViewControllerAnimated:YES];

        }];
        
    };
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
