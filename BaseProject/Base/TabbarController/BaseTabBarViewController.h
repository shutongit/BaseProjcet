//
//  BaseTabBarViewController.h
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabbar.h"
/**
 分类控制器
 */
@interface BaseTabBarViewController : UITabBarController

@property (nonatomic, copy) void (^clickCustormButton)();
@property (nonatomic, strong) BaseTabbar *TabBar;

/**
 tabbar 图片占比，默认0.7f，如果是1 就没有文字
 */
@property (nonatomic, assign) CGFloat itemImageRatio;

//取出系统自带的tabbar并把里面的按钮删除掉
- (void)removeOriginControls;
@end
