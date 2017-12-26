//
//  BaseHeadTableViewCell.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/7.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMineHeadTableViewCell.h"

@implementation BaseMineHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    BSViewsBorder(self.headImageView, 60/2, 1, CFontColor2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
