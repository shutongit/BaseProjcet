//
//  BaseButtonView.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/5.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseButtonView.h"
#import "UIButton+BaseEdgImageOrTitle.h"

@implementation BaseButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
#pragma mark  ************** touch event **************
- (void)buttonAction:(UIButton *)aSender
{
    if (_clickButton) {
        _clickButton(aSender.tag);
    }
}

#pragma mark  ************** public method **************
- (void)configureButtonImages:(NSArray *)images titles:(NSArray *)titles
{
    for (int i = 0; i < MIN(titles.count, images.count); i ++) {
        CGFloat btnW = KScreenWidth/4;
        CGFloat btnH = 75;
        CGFloat btnY = 10+ i / 4 * btnH;
        CGFloat btnX = i % 4 * btnW;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        button.tag = 10 + i;
        button = [UIButton EdgeInsetImageAndTitleWith:button];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
}

@end
