//
//  BaseApplyForAskForLevelTimeGapTableViewCell.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/14.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseApplyForAskForLevelTimeGapTableViewCell.h"
#import "UIButton+BaseEdgImageOrTitle.h"
#import "BaseMessageView.h"

@implementation BaseApplyForAskForLevelTimeGapTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.timeType = [UIButton EdgeInsetTitleAndImageWith:self.timeType];
}
- (IBAction)timeTypeAction:(id)sender {
    kWS(weakSelf)
    kSS(strongSelf)
    [[BaseMessageView  sharedBaseMessageView] showMessageViewFrame:CGRectMake(KScreenWidth - 120, 188 + 64, 100, 150) dataSource:@[@"天数",@"小时"]];
    [BaseMessageView sharedBaseMessageView].chooseMessage = ^(NSString *message) {
        [strongSelf.timeType setTitle:message forState:UIControlStateNormal];
        if (_clickButtonType) {
            _clickButtonType(message);
        }
    };
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
