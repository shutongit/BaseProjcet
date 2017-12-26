//
//  BaseApplyForCollectionViewCell.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/13.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseApplyForCollectionViewCell.h"

@implementation BaseApplyForCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentButton.showsTouchWhenHighlighted = NO;
    self.backgroundColor = [UIColor whiteColor];
//    BSViewsBorder(self, 0, 0.8, [UIColor lightGrayColor]);
}


/**
 不能响应了，xib中把用户响应取消掉了

 @param sender sender description
 */
- (IBAction)clickAction:(id)sender {
    if (_clickButton) {
        _clickButton();
    }
}
@end
