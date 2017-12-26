//
//  UIAlertView+Extension.m
//  SKKit
//
//  Created by maxin on 16/5/7.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import "UIAlertView+Extension.h"

static confirmBlock kconfirmBlock;
static cancelBlock  kcancelBlock;

@implementation UIAlertView (Extension)


+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelTitle
                     confirmButtonTitle:(NSString *)confirmTitle
                               onCancel:(cancelBlock)cancel
                              onConfirm:(confirmBlock)confirm{

    kcancelBlock       = [cancel copy];
    kconfirmBlock      = [confirm copy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self self]
                                          cancelButtonTitle:cancelTitle
                                          otherButtonTitles:confirmTitle,nil];
    [alert show];
    return alert;
    
}

+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
    if ( buttonIndex == [alertView cancelButtonIndex] ){
        if (kcancelBlock) {
            kcancelBlock();
        }
    } else {
        
        if (kconfirmBlock) {
            kconfirmBlock();
        }
    }
}

@end
