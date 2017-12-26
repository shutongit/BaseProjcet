//
//  AppDelegate+AppService.h
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "AppDelegate.h"

/**
 包含第三方 和 应用内业务的实现，减轻入口代码压力
 */
@interface AppDelegate (AppService)

/**
 初始化服务
 */
- (void)initService;

/**
 配置键盘
 */
- (void)configureKeyboardManager;
/**
 初始化window
 */
- (void)initWindow;

/**
 初始化高德地图
 */
- (void)initGDMap;
/**
 检测网络状态
 */
- (void)monitorNetworkStatus;
/**
 初始化用户
 */
-(void)initUserManager;

/**
 初始化友盟
 */
- (void)initUmeng;
//单例
+ (AppDelegate *)shareAppDelegate;

/**
 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;

@end
