//
//  CustomerDetailCell.m
//  AgentManagement
//
//  Created by huabin on 16/9/20.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "CustomerDetailCell.h"

@implementation CustomerDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .heightIs(19);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    
    self.textField.sd_layout
    .leftSpaceToView(self.titleLabel,10)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,13)
    .heightIs(19);
    
    self.textView.sd_layout
    .leftSpaceToView(self.titleLabel,10)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,3)
    .bottomSpaceToView(self.contentView,0);
    
    
    self.labelA.sd_layout
    .leftSpaceToView(self.titleLabel,10)
    .topSpaceToView(self.contentView,13)
    .rightSpaceToView(self.contentView,0)
    .heightIs(19);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithTitle:(NSArray*)titleArray customer:(AMCustomer*)customer indexPaht:(NSIndexPath*)indexPath {

   // NSString *labelTag = [NSString stringWithFormat:@"10%ld%ld",indexPath.section,indexPath.row];
    //NSString *textFiledTag = [NSString stringWithFormat:@"20%ld%ld",indexPath.section,indexPath.row];
    
    //self.labelA.tag = [labelTag integerValue];
    //self.textField.tag = [textFiledTag integerValue];
    
    if (indexPath.section == 0) {

        self.titleLabel.text = [titleArray[indexPath.section]objectAtIndex:indexPath.row];
        
        if (indexPath.row==2) {
            
            self.textView.hidden = self.textField.hidden = YES;
            self.labelA.hidden = NO;
            
            NSString *address = [NSString stringWithFormat:@"%@市",customer.province];
            
            NSString *str = @"";
            
            if ([address isEqualToString:customer.city]) {
                
                str = [NSString stringWithFormat:@"%@%@",customer.city,customer.county];
                
            }
            else {
                
                str = [NSString stringWithFormat:@"%@%@%@",customer.province,customer.city,customer.county];
                
            }
            
            self.labelA.text = str;
        }
        else if (indexPath.row == 3) {
            
            self.labelA.hidden = self.textField.hidden = YES;
            self.textView.hidden = NO;
            self.textView.text = customer.address;
        }
        else {
            
            self.labelA.hidden = self.textView.hidden = YES;
            self.textField.hidden = NO;
            self.textField.text = indexPath.row==0?customer.name:customer.phone;
        }

    }
    
    else if (indexPath.section == 1) {
        
        self.titleLabel.text = [titleArray[indexPath.section]objectAtIndex:indexPath.row];
        
        self.textField.hidden = NO;
        self.textView.hidden = YES;
        self.labelA.hidden = YES;
        
        if (indexPath.row == 0) {
            
            self.textField.text = [NSString stringWithFormat:@"%ld",(long)customer.tds];
            
        }
        
        else if (indexPath.row == 1) {
            
            self.textField.text =  [NSString stringWithFormat:@"%ld",(long)customer.ph];
        }
        else if (indexPath.row == 2) {
            
             self.textField.text =  [NSString stringWithFormat:@"%ld",(long)customer.hardness];
        }
        else {
            
            self.textField.text = [NSString stringWithFormat:@"%ld",(long)customer.chlorine];
        }

    }
    
    else if (indexPath.section == 3+customer.orderArray.count-1) {
        
        self.titleLabel.text = [titleArray[3]objectAtIndex:indexPath.row];
        
        self.textField.hidden = YES;
        self.textView.hidden = YES;
        
         self.labelA.hidden = NO;
        
        if (indexPath.row == 0) {
            
           // self.textField.text =  [NSString stringWithFormat:@"%ld",customer.a_id];

        }
        else {
            
           // self.textField.text =
        }

    }
    
    else {
      
        self.titleLabel.text = [titleArray[2]objectAtIndex:indexPath.row];
        
        self.textView.hidden=self.textField.hidden = YES;
        self.labelA.hidden = NO;
        
        AMOrder *order = customer.orderArray[indexPath.section-2];
        
        if (indexPath.row == 0) {
            
            self.labelA.text = [NSString stringWithFormat:@"%@   %@",order.brand,order.pmodel];
        }
        else if (indexPath.row == 1) {
            
            NSString *string = order.buy_time;
            
            NSArray *strArr = [string componentsSeparatedByString:@" "];
            
            self.labelA.text = strArr[0];

        }
        else if (indexPath.row == 2) {
            
            NSString *string = order.install_time;
            
            NSArray *strArr = [string componentsSeparatedByString:@" "];
            
            self.labelA.text = strArr[0];
            
        }
        else {
            
            self.labelA.text = order.cycle;
        }
        
    }
}

@end
