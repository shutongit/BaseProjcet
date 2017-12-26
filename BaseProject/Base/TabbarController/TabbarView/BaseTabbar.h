//
//  BaseTabbar.h
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarItem.h"
@class BaseTabbar;

@protocol TabBarDelegate <NSObject>

@optional
- (void)tabBar:(BaseTabbar *)tabBarView didSelectedItemFrom:(NSInteger)from to:(NSInteger)to;

@end


@interface BaseTabbar : UIView

/**
 *  TabBar item title color
 */
@property (nonatomic, strong) UIColor *itemTitleColor;

/**
 *  TabBar selected item title color
 */
@property (nonatomic, strong) UIColor *selectedItemTitleColor;

/**
 *  TabBar item title font
 */
@property (nonatomic, strong) UIFont *itemTitleFont;

/**
 *  TabBar item's badge title font
 */
@property (nonatomic, strong) UIFont *badgeTitleFont;

/**
 *  TabBar item image ratio
 */
@property (nonatomic, assign) CGFloat itemImageRatio;

/**
 *  TabBar's item count
 */
@property (nonatomic, assign) NSInteger tabBarItemCount;

/**
 *  TabBar's selected item
 */
@property (nonatomic, strong) BaseTabBarItem *selectedItem;

/**
 *  TabBar items array
 */
@property (nonatomic, strong) NSMutableArray *tabBarItems;

/**
 *  TabBar delegate
 */
@property (nonatomic, weak) id<TabBarDelegate> delegate;



// 自定义的按钮
@property (nonatomic, strong) UIButton *custormImageBtn;

@property (nonatomic, copy) void (^custormClik)();

/**
 *  Add tabBar item
 */
- (void)addTabBarItem:(UITabBarItem *)item;

@end
