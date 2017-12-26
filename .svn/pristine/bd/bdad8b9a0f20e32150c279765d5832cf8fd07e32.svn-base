//
//  UIActionSheet+BaseActionSheet.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/11.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^cancelBlock)();
typedef void (^confirmFirstBlock)();
typedef void (^confirmSecondBlock)();

@interface UIActionSheet (BaseActionSheet)<UIActionSheetDelegate>


+ (UIActionSheet *)showActionSheetWithTitle:(NSString *)title
                                  confirmTitleFirst:(NSString *)firstTitle
                                  confirmTitleSecond:(NSString *)secondTitle
                                  cancelButtonTitle:(NSString *)cancelTitle
                        onCancel:(cancelBlock)cancel
                        onFirstConfirm:(confirmFirstBlock)firstConfirm
                        onSecondConfirm:(confirmSecondBlock)secondConfirm;

@end
