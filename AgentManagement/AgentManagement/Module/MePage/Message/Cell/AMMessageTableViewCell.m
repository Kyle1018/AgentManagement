//
//  AMMessageTableViewCell.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMMessageTableViewCell.h"

NSString *const kMessageCellIdentify = @"kMessageCellIdentify-jfdlajfl";

@interface AMMessageTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *messageTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *messageContentLabel;

@end

@implementation AMMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (NSString *)reuseIdentifier {
    return kMessageCellIdentify;
}

+ (CGFloat)cellHeightForMessage:(AMMessage *)message {
    CGFloat titleHeight = [@"" sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17.]}].width;
    CGFloat contentHeight = [self multiLineheightForString:@"" font:[UIFont systemFontOfSize:14.] maxWidth:(ScreenWidth - 2 * 10.)];
    
    return (10. + 10. + 1. + 15. + 2 *10. + titleHeight + contentHeight + 2.);
}

+ (CGFloat)multiLineheightForString:(NSString *)string font:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    if ((string.length <= 0) || !font || (maxWidth <= 0.)) {
        return 0.;
    }
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName : font}];
    CGFloat height = 0.;
    NSInteger lineCount = (size.width / maxWidth);
    
    if ((lineCount * maxWidth - size.width) < 0.) {
        lineCount++;
    }
    height = size.height * lineCount;
    return height;
}

- (void)updateWithMessage:(AMMessage *)message {
    self.messageTitleLabel.text = nil;
    self.messageContentLabel.text = nil;
}

@end
