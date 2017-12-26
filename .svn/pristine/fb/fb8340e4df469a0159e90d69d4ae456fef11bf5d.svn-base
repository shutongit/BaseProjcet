//
//  BaseMessageBannerView.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/8.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMessageBannerView.h"

@implementation BaseMessageBannerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    BSViewsBorder(self.cancelButton, 15/2, 0, [UIColor clearColor]);
}

- (IBAction)cancelAction:(id)sender {
    if (_clickCancel) {
        _clickCancel();
    }
}
@end
