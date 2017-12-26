//
//  BaseButtonView.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/5.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseButtonView : UIView

@property (nonatomic, copy) void (^clickButton)(NSInteger);
/**
 配置按钮的图片文字
 
 @param images images description
 @param titles titles description
 */
- (void)configureButtonImages:(NSArray *)images titles:(NSArray *)titles;
@end
