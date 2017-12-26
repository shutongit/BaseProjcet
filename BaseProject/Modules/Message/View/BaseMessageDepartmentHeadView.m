//
//  BaseMessageDepartmentHeadView.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/7.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMessageDepartmentHeadView.h"

@implementation BaseMessageDepartmentHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.isPull = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}
- (void)tapAction:(UITapGestureRecognizer *)tap
{

    DLog(@"self ispull %d",self.isPull);
    if (self.isPull == YES) {
        self.isPull = NO;
    } else {
        self.isPull = YES;
    }
    DLog(@"self ispull %d",self.isPull);
    if (_clickHeadView) {
        _clickHeadView(self.isPull);
        //        self.isPull = NO;
    }
    [self setNeedsDisplay];
}
- (void)setIsPull:(BOOL)isPull
{
    _isPull = isPull;
    if (isPull) {
        self.pullImage.image = [UIImage imageNamed:@"pullUp"];
    } else {
        self.pullImage.image = [UIImage imageNamed:@"pullDown"];
    }
}

@end
