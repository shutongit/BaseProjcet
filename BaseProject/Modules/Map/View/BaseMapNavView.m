//
//  BaseMapNavView.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/10.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMapNavView.h"

@implementation BaseMapNavView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)backAction:(id)sender {
    if (_clickBack) {
        _clickBack();
    }
}

- (IBAction)rightAction:(id)sender {
    if (_clickRight) {
        _clickRight();
    }
}
@end
