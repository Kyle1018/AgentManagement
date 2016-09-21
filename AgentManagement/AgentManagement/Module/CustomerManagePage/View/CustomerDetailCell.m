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

//    self.textView.backgroundColor=[UIColor redColor];
//    
//    self.textField.backgroundColor=[UIColor greenColor];
//    
//   // self.labelB.backgroundColor=[UIColor brownColor];
//    
//    self.labelA.backgroundColor=[UIColor purpleColor];
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .heightIs(19);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    
    self.textField.sd_layout
    .leftSpaceToView(self.titleLabel,10)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,10)
    .heightIs(19);
    
    self.textView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    
    
    self.labelA.sd_layout
    .leftSpaceToView(self.titleLabel,10)
    .topSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,0)
    .heightIs(19);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithTitle:(NSArray*)titleArray customer:(AMCustomer*)customer indexPaht:(NSIndexPath*)indexPath {
    
    if (indexPath.section == 0) {
   
        self.titleLabel.text = [titleArray[indexPath.section]objectAtIndex:indexPath.row];
        
        self.textField.hidden = indexPath.row==2?YES:NO;
        self.textView.hidden = indexPath.row == 2?NO:YES;
        self.labelA.hidden = YES;
        
        if (indexPath.row == 0) {
            
            self.textField.text = customer.name;
        }
        else if (indexPath.row == 1) {
            
            self.textField.text = customer.phone;
        }
        else {
            
            self.textView.text = customer.address;
        }
    }
    else if (indexPath.section == 1) {
        
        self.titleLabel.text = [titleArray[indexPath.section]objectAtIndex:indexPath.row];
        
        self.textField.hidden = NO;
        self.textView.hidden = YES;
        
        self.labelA.hidden = YES;
        
        if (indexPath.row == 0) {
            
            self.textField.text = [NSString stringWithFormat:@"%ld",customer.tds];
            
        }
        
        else if (indexPath.row == 1) {
            
            self.textField.text =  [NSString stringWithFormat:@"%ld",customer.ph];
        }
        else if (indexPath.row == 2) {
            
             self.textField.text =  [NSString stringWithFormat:@"%ld",customer.hardness];
        }
        else {
            
            self.textField.text = [NSString stringWithFormat:@"%ld",customer.chlorine];
        }

    }
    
    else if (indexPath.section == 4+customer.orderArray.count-1) {
        
        self.titleLabel.text = @"";
       
        self.textView.hidden = self.textField.hidden = YES;
        
        self.labelA.hidden = NO;
        
        self.labelA.sd_layout.leftSpaceToView (self.contentView,0);
        
        self.labelA.text = @"继续添加";
        
        self.labelA.textAlignment = NSTextAlignmentCenter;
        
        self.labelA.font = [UIFont systemFontOfSize:17.f];
        
        self.labelA.textColor = [UIColor colorWithHex:@"9b9b9b"];
       
    
    }//最后一组
    
    else if (indexPath.section == 4+customer.orderArray.count-2) {
        
        self.titleLabel.text = [titleArray[3]objectAtIndex:indexPath.row];
        
        self.textField.hidden = NO;
        self.textView.hidden = YES;
        
         self.labelA.hidden = YES;
        
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
            
            self.labelA.text = order.buy_time;
        }
        else if (indexPath.row == 2) {
            
            self.labelA.text = order.install_time;
            
        }
        else {
            
            self.labelA.text = order.cycle;
        }
        
    }

}

@end
