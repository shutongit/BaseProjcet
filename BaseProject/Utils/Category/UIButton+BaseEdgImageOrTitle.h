//
//  UIButton+BaseEdgImageOrTitle.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/5.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    topToBottom = 0,//从上到小
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
}GradientType;

@interface UIButton (BaseEdgImageOrTitle)


/**
 调整图片和文字的偏移量

 @param button 需要修改的button
 @return 调整过后的button
 */
+ (UIButton *)EdgeInsetImageAndTitleWith:(UIButton *)button;

/**
 调整文字和图片的偏移量

 @param button button
 @return 调整过后的button
 */
+ (UIButton *)EdgeInsetTitleAndImageWith:(UIButton *)button;

/**
 修改button背景颜色为渐变色

 @param colorArray 开始的颜色
 @param gradientType 结束的颜色
 @param button 需要修改的button
 @return 渐变色
 */
+ (UIButton *)changeColorArray:(NSMutableArray*)colorArray ByGradientType:(GradientType)gradientType button:(UIButton *)button;

@end
