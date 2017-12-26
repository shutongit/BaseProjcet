//
//  UIAlertView+Extension.h
//  SKKit
//
//  Created by maxin on 16/5/7.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^confirmBlock)();
typedef void (^cancelBlock)();

@interface UIAlertView (Extension) <UIAlertViewDelegate>

+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelTitle
                     confirmButtonTitle:(NSString *)confirmTitle
                               onCancel:(cancelBlock)cancel
                              onConfirm:(confirmBlock)confirm;


@end
