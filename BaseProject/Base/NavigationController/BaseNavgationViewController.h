//
//  BaseNavgationViewController.h
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseRootViewController.h"

@interface BaseNavgationViewController : UINavigationController

/**
 返回到指定的类视图

 @param ClassName 类名
 @param animated 是否动画
 @return return value description
 */
- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;

@end
