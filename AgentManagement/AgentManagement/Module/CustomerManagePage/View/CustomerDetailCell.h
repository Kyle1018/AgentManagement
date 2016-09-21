//
//  CustomerDetailCell.h
//  AgentManagement
//
//  Created by huabin on 16/9/20.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMCustomer.h"
@interface CustomerDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *labelA;
//@property (weak, nonatomic) IBOutlet UILabel *labelB;

- (void)setDataWithTitle:(NSArray*)titleArray customer:(AMCustomer*)customer indexPaht:(NSIndexPath*)indexPath;

@end
