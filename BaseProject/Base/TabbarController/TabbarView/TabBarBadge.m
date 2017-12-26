//
//  TabBarBadge.m
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "TabBarBadge.h"

@implementation TabBarBadge

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.hidden = YES;
        [self setBackgroundImage:IMAGE_NAMED(@"LCTabBarBadge") forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark  ************** setter / getter **************
- (void)setBadgeTitleFont:(UIFont *)badgeTitleFont
{
    _badgeTitleFont = badgeTitleFont;
    self.titleLabel.font = badgeTitleFont;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    self.hidden = !(BOOL)self.badgeValue;
    if (self.badgeValue) {
        [self setTitle:badgeValue forState:UIControlStateNormal];
        CGRect frame = self.frame;
        if (self.badgeValue.length > 0) {
            CGSize badgeSize = self.currentBackgroundImage.size;
            CGSize titleSize = [badgeValue sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.badgeTitleFont,NSFontAttributeName, nil]];
            //文字宽度可能大于试图宽度
            frame.size.width = MAX(badgeSize.width, titleSize.width + 10);
            frame.size.height = badgeSize.height;
        } else {
            frame.size.width = 12.0f;
            frame.size.height = frame.size.width;
        }
        frame.origin.x = 58.0f * ([UIScreen mainScreen].bounds.size.width / self.tabBarItemCount) / 375.0f * 4.0f;
        frame.origin.y = 2.0f;
        self.frame = frame;
    }
}


#pragma mark  ************** private method **************
//创建内容可以拉伸 边角不拉伸的image
- (UIImage *)resizedImageFromMiddle:(UIImage *)image
{
    return [self resizedImage:image width:0.5f height:0.5f];
}
- (UIImage *)resizedImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height {
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * width
                                      topCapHeight:image.size.height * height];
}




@end
