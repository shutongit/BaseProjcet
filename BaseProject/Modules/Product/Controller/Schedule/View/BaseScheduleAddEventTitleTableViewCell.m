//
//  BaseScheduleAddEventTitleTableViewCell.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/18.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseScheduleAddEventTitleTableViewCell.h"

@interface BaseScheduleAddEventTitleTableViewCell ()<UITextFieldDelegate>

@end
@implementation BaseScheduleAddEventTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

#pragma mark  ************** textField delegate **************
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([NSString isBlankString:textField.text]) {
        if (_contentText) {
            _contentText(textField.text);
        }
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([NSString isBlankString:textField.text]) {
        if (_contentText) {
            _contentText(textField.text);
        }
    }
    return YES;
}

@end
