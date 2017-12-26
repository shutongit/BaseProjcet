//
//  UIActionSheet+BaseActionSheet.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/11.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "UIActionSheet+BaseActionSheet.h"

static cancelBlock kCancelBlock;
static confirmFirstBlock kFirstConfirmBlock;
static confirmSecondBlock kSecondConfirmBlock;

@implementation UIActionSheet (BaseActionSheet)

+ (UIActionSheet *)showActionSheetWithTitle:(NSString *)title
                          confirmTitleFirst:(NSString *)firstTitle
                         confirmTitleSecond:(NSString *)secondTitle
                          cancelButtonTitle:(NSString *)cancelTitle
                                   onCancel:(cancelBlock)cancel
                             onFirstConfirm:(confirmFirstBlock)firstConfirm
                            onSecondConfirm:(confirmSecondBlock)secondConfirm
{
    kCancelBlock = [cancel copy];
    kFirstConfirmBlock = [firstConfirm copy];
    kSecondConfirmBlock = [secondConfirm copy];
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:title delegate:[self self]cancelButtonTitle:cancelTitle destructiveButtonTitle:nil otherButtonTitles:firstTitle,secondTitle, nil];
    [sheet showInView:kAppWindow];
    return sheet;
}
+ (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [actionSheet cancelButtonIndex]) {
        if (kCancelBlock) {
            kCancelBlock();
        }
    } else if (buttonIndex == 0) {
        if (kFirstConfirmBlock) {
            kFirstConfirmBlock();
        }
    } else {
        if (kSecondConfirmBlock) {
            kSecondConfirmBlock();
    }
    }
}

@end
