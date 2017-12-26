//
//  UIButton+BaseEdgImageOrTitle.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/5.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "UIButton+BaseEdgImageOrTitle.h"

@implementation UIButton (BaseEdgImageOrTitle)

//图片上文字下
+ (UIButton *)EdgeInsetImageAndTitleWith:(UIButton *)button
{
    CGFloat offset = 10.0f;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -MIN(button.imageView.frame.size.width, button.frame.size.width), -MIN(button.imageView.frame.size.height, button.frame.size.height)-offset/2, 0);
    // button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.frame.size.height-offset/2, 0, 0, -button.titleLabel.frame.size.width);
    // 由于iOS8中titleLabel的size为0，用上面这样设置有问题，修改一下即可
    button.imageEdgeInsets = UIEdgeInsetsMake(-MIN(button.titleLabel.intrinsicContentSize.height, button.frame.size.height)-offset/2, 0, 0, -MIN(button.titleLabel.intrinsicContentSize.width, button.frame.size.width));
    return button;
}
//图片下文字上
+ (UIButton *)EdgeInsetTitleAndImageWith:(UIButton *)button
{
    CGFloat imageW = button.imageView.frame.size.width;
    CGFloat imageH = button.imageView.frame.size.height;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -MIN(imageW, button.frame.size.width), MIN(imageH, button.frame.size.height), 0.f)];
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(MIN(button.titleLabel.intrinsicContentSize.height, button.frame.size.height), 0.f, 0.f,-MIN(button.titleLabel.intrinsicContentSize.width, button.frame.size.width))];
//    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    return button;
}
//button背景颜色渐变色
+ (UIButton *)changeColorArray:(NSMutableArray*)colorArray ByGradientType:(GradientType)gradientType button:(UIButton *)button
{
    UIImage *backImage = [button buttonImageFromColors:colorArray ByGradientType:gradientType button:button];
    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    return button;
}
- (UIImage*) buttonImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType button:(UIButton *)button{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(button.frame.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    
    switch (gradientType) {
        case 0:////从上到小
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, button.frame.size.height);
            break;
        case 1:////从左到右
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(button.frame.size.width, 0.0);
            break;
        case 2:////左上到右下
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(button.frame.size.width, button.frame.size.height);
            break;
        case 3: ////右上到左下
            start = CGPointMake(button.frame.size.width, 0.0);
            end = CGPointMake(0.0, button.frame.size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end
