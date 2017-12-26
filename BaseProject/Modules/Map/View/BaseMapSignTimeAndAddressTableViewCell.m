//
//  BaseMapSignTimeAndAddressTableViewCell.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/10.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMapSignTimeAndAddressTableViewCell.h"

@implementation BaseMapSignTimeAndAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    BSViewsBorder(self.tipLabel, 5/2, 0, [UIColor clearColor]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
