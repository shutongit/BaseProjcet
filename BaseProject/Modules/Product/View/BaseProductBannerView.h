//
//  BaseProductBannerView.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/6.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseProductBannerView : UIView

/**
 关闭视图
 */
@property (nonatomic, copy) void (^closeBlock)();

/**
 点击banner
 */
@property (nonatomic, copy) void (^clickBanner)(NSInteger);
@end
