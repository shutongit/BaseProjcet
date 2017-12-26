//
//  BaseMapSignView.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/10.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMapSignView.h"

@implementation BaseMapSignView

- (void)awakeFromNib
{
    [super awakeFromNib];
    BSViewsBorder(self.signButton, 60/2, 2, [UIColor lightGrayColor]);
}

- (IBAction)signAction:(id)sender {
    if (_clickSign) {
        _clickSign();
    }
}
@end
