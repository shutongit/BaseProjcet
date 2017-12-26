//
//  BaseHomeTableViewCell.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/8.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseHomeTableViewCell.h"

@implementation BaseHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    BSViewsBorder(self.headImageView, 40 / 2, 0, [UIColor clearColor]);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
