//
//  TabBarItem.h
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarItem : UIButton

/**
 TabBar item
 */
@property (nonatomic, strong) UITabBarItem *tabBarItem;

/**
 TabBar's item count
 */
@property (nonatomic, assign) NSInteger tabBarItemCount;

/**
 TabBar item title color
 */
@property (nonatomic, strong) UIColor *itemTitleColor;

/**
 TabBar selected item title color
 */
@property (nonatomic, strong) UIColor *selectedItemTitleColor;

/**
 TabBar item title font
 */
@property (nonatomic, strong) UIFont *itemTitleFont;

/**
 TabBar item's badge title font
 */
@property (nonatomic, strong) UIFont *badgeTitleFont;

/**
 TabBar item imageRatio
 */
@property (nonatomic, assign) CGFloat itemImageRatio;

/**
 TabBar item init

 @param itemImageRatio itemImageRatio description
 @return TabBar
 */
- (instancetype)initWithItemImageRatio:(CGFloat)itemImageRatio;


@end
