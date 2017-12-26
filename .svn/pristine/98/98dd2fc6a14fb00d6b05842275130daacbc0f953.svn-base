//
//  BaseMineDataTableViewCell.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/11.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseMineDataTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UITextField *rightTextField;
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;

@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSString *rightString;
@property (copy, nonatomic) NSString *imagePath;

@property (copy, nonatomic) void (^editContent)(NSString *text);
/**
 编辑状态，显示输入框
 */
- (void)showTextField:(NSString *)text;

/**
 编辑状态，显示选中内容

 @param text text description
 */
- (void)showChooseLabel:(NSString *)text;
@end
