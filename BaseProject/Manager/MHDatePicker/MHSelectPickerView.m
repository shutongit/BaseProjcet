//
//  MHSelectPickerView.m
//  MHDatePicker
//
//  Created by LMH on 16/03/12.
//  Copyright (c) 2015年 LMH. All rights reserved.
//

#import "MHSelectPickerView.h"

@implementation MHSelectPickerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _lineWidth.constant = 1;
    _lineHeight.constant = 0.5;
    
    [_confirmBtn setTitleColor:RGB(136, 136, 136) forState:0];
}

@end
