//
//  BaseMineDataTableViewCell.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/11.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseMineDataTableViewCell.h"

@interface BaseMineDataTableViewCell ()<UITextFieldDelegate>

@end
@implementation BaseMineDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    BSViewsBorder(self.rightImage, 35/2, 0, [UIColor clearColor]);
    self.rightTextField.delegate = self;
    
}

#pragma mark  ************** public method **************
- (void)showTextField:(NSString *)text
{
    self.rightTextField.hidden = NO;
    self.rightLabel.hidden = self.chooseLabel.hidden = self.rightImage.hidden = YES;
    if (![NSString isBlankString:text]) {
        self.rightTextField.text = text;
    }
}
- (void)showChooseLabel:(NSString *)text
{
    self.chooseLabel.hidden = NO;
    self.rightLabel.hidden = self.rightTextField.hidden = self.rightImage.hidden = YES;
    self.chooseLabel.text = [NSString isBlankString:text] ? @"暂无" : text;
}
#pragma mark  ************** uitextfield delegate **************
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_editContent) {
        _editContent(textField.text);
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (_editContent) {
        _editContent(textField.text);
    }
    return YES;
}

#pragma mark  ************** setter / getter **************
- (void)setMessage:(NSString *)message
{
    _message = message;
    self.messageLabel.text = message;
}

- (void)setRightString:(NSString *)rightString
{
    _rightString = rightString;
    self.rightLabel.hidden = NO;
    self.chooseLabel.hidden = YES;
    self.rightImage.hidden = YES;
    self.rightTextField.hidden = YES;
    self.rightLabel.text = rightString;
}

- (void)setImagePath:(NSString *)imagePath
{
    _imagePath = imagePath;
    self.rightImage.hidden = NO;
    self.rightLabel.hidden = YES;
    self.chooseLabel.hidden = YES;
    self.rightTextField.hidden = YES;
    [self.rightImage sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"userface"]];
}

@end
