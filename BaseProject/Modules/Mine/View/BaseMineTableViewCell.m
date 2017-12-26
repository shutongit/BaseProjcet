//
//  BaseMineTableViewCell.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/12.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMineTableViewCell.h"

@implementation BaseMineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
