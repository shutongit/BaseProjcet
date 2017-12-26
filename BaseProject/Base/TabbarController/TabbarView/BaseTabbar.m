//
//  BaseTabbar.m
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseTabbar.h"
#import "BaseTabBarItem.h"


@implementation BaseTabbar



- (void)addTabBarItem:(UITabBarItem *)item {
    
    BaseTabBarItem *tabBarItem = [[BaseTabBarItem alloc] initWithItemImageRatio:self.itemImageRatio];
    
    tabBarItem.badgeTitleFont         = self.badgeTitleFont;
    tabBarItem.itemTitleFont          = self.itemTitleFont;
    tabBarItem.itemTitleColor         = self.itemTitleColor;
    tabBarItem.selectedItemTitleColor = self.selectedItemTitleColor;
    
    tabBarItem.tabBarItemCount = self.tabBarItemCount;
    
    tabBarItem.tabBarItem = item;
    
    [tabBarItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:tabBarItem];
    
    [self.tabBarItems addObject:tabBarItem];
    
    if (self.tabBarItems.count == 1) {
        
        [self buttonClick:tabBarItem];
    }
}

- (void)buttonClick:(BaseTabBarItem *)tabBarItem {
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedItemFrom:to:)]) {
        
        [self.delegate tabBar:self didSelectedItemFrom:self.selectedItem.tabBarItem.tag to:tabBarItem.tag];
    }
    //防止自定义的tabbaritem呈现出选中样式
    if (tabBarItem.tag != 2) {
        self.selectedItem.selected = NO;
        self.selectedItem = tabBarItem;
        self.selectedItem.selected = YES;
    }
    
}
- (void)custormAction:(UIButton *)aSender
{
    BaseTabBarItem *tabBarItem = [self viewWithTag:2];
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedItemFrom:to:)]) {
        
        [self.delegate tabBar:self didSelectedItemFrom:self.selectedItem.tabBarItem.tag to:2];
    }
    
    self.selectedItem.selected = NO;
    self.selectedItem = tabBarItem;
    self.selectedItem.selected = YES;
    
//    if (self.custormClik) {
//        self.custormClik();
//    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    int count = (int)self.tabBarItems.count;
    CGFloat itemY = 0;
    CGFloat itemW = w / self.subviews.count;
    CGFloat itemH = h;
    
    for (int index = 0; index < count; index++) {
        CGFloat itemX = index * itemW;
        BaseTabBarItem *tabBarItem = self.tabBarItems[index];
        tabBarItem.tag = index;
        
        if (index == 2) {
            DLog(@"自定义Tabbar按钮");
            tabBarItem.frame = CGRectMake(itemX, -20, itemW, itemH+20);

        } else {
            
            tabBarItem.frame = CGRectMake(itemX, itemY, itemW, itemH);
        }
    }
}

- (UIButton *)EdgeInsetImageAndTitleWith:(UIButton *)button
{
    CGFloat offset = 5.0f;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -MIN(button.imageView.frame.size.width, button.frame.size.width), -MIN(button.imageView.frame.size.height, button.frame.size.height)-20, 0);
    // 由于iOS8中titleLabel的size为0，用上面这样设置有问题，修改一下即可
    button.imageEdgeInsets = UIEdgeInsetsMake(-MIN(button.titleLabel.intrinsicContentSize.height, button.frame.size.height)-offset/2, 0, 0, -MIN(button.titleLabel.intrinsicContentSize.width, button.frame.size.width));
    return button;
}

#pragma mark  ************** setter／ getter **************
- (NSMutableArray *)tabBarItems {
    
    if (_tabBarItems == nil) {
        
        _tabBarItems = [[NSMutableArray alloc] init];
    }
    return _tabBarItems;
}
@end
