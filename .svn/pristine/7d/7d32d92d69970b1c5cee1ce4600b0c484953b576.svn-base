//
//  BasePhoneBookTableViewCell.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/5.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BasePhoneBookTableViewCell.h"

@implementation BasePhoneBookTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    BSViewsBorder(self.InviteButton, 5, 0, [UIColor clearColor]);
}
- (IBAction)buttonAction:(id)sender {
    if (_clickInvite) {
        _clickInvite(self.model.Name);
    }
}

- (void)setModel:(BasePhoneBookModel *)model
{
    _model = model;
    self.titleLabel.text = model.Name;
}


@end
