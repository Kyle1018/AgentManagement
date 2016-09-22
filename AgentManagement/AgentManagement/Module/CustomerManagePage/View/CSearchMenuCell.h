//
//  CSearchMenuCell.h
//  AgentManagement
//
//  Created by huabin on 16/9/22.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSearchMenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property(nonatomic,assign)NSInteger sectionIndex;
@end
