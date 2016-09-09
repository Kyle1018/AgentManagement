//
//  MenuCollectionViewCell.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/29.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *optionLabel;

- (void)setTitleData:(NSString*)text color:(UIColor*)color;
@end
