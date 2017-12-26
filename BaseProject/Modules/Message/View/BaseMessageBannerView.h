//
//  BaseMessageBannerView.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/8.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseMessageBannerView : UIView

@property (copy, nonatomic) void (^clickCancel)();
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
- (IBAction)cancelAction:(id)sender;

@end
