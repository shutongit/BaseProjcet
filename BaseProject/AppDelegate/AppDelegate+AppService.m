//
//  AppDelegate+AppService.m
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "BaseLogInViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation AppDelegate (AppService)

#pragma mark  ************** 初始化服务 **************
- (void)initService
{
    //监听注册登陆状态
    [kNotificationCenter addObserver:self selector:@selector(loginStateChange:) name:KNotificationLoginStateChange object:nil];
    //监听网络状态
    [kNotificationCenter addObserver:self selector:@selector(netWorkStateChange:) name:KNotificationNetWorkStateChange object:nil];
}
#pragma mark  ************** 初始化window **************
- (void)initWindow
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[UIButton appearance]setExclusiveTouch:YES];//避免在一个界面上同时点击多个button。
}
//配置键盘
- (void)configureKeyboardManager {
    IQKeyboardManager.sharedManager.enableAutoToolbar = YES;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = YES;
}
//初始化高德地图
- (void)initGDMap
{
    //开启 HTTPS 功能
//    [[AMapServices sharedServices] setEnableHTTPS:YES];
    //添加高德Key
    [AMapServices sharedServices].apiKey = GDMapKey;
    
}
#pragma mark  ************** 配置友盟 **************
//初始化友盟
- (void)initUmeng
{
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengKey];
  
    [self configUSharePlatforms];
}
//配置友盟
- (void)configUSharePlatforms
{
    // 设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kAppKey_Wechat appSecret:kSecret_Wechat redirectURL:nil];
    
    //设置qq的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kAppKey_Tencent/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
}


#pragma mark  ************** OpenURL 回调 **************
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        //其他支付等 sdk的回调
    }
    return  result;
}

#pragma mark  ************** 初始化用户系统 **************
- (void)initUserManager
{
    if ([userManager loadUserInfo]) {
        //读取本地数据
        self.baseTabBar = [BaseTabBarViewController new];
        self.window.rootViewController = self.baseTabBar;
    } else {
        KPostNotification(KNotificationLoginStateChange, @NO);
    }
    
}

//单例
+ (AppDelegate *)shareAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

//获取当前顶层控制器
- (UIViewController *)getCurrentVC
{
    UIViewController *currentVC = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews]objectAtIndex:0];//取出第一个试图
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        currentVC = nextResponder;
    else
        currentVC = window.rootViewController;
    
    return currentVC;
}

- (UIViewController *)getCurrentUIVC
{
    UIViewController *superVC = [self getCurrentVC];
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        UIViewController *tabSelectVC = ((UITabBarController *)superVC).selectedViewController;
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            return [((UINavigationController *)tabSelectVC).viewControllers lastObject];
        }
        return tabSelectVC;
    } else  if ([superVC isKindOfClass:[UINavigationController class]]) {
        return [((UINavigationController *)superVC).viewControllers lastObject];
    }
    return superVC;
}

#pragma mark  ************** private method **************
//登陆状态处理
- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
    if (loginSuccess) {//登陆成功 加载主窗口
        if (!self.baseTabBar || ![self.window.rootViewController isKindOfClass:[BaseTabBarViewController class]]) {
            self.baseTabBar = [[BaseTabBarViewController alloc]init];
            self.window.rootViewController = self.baseTabBar;
        }
    } else {
        self.baseTabBar = nil;
        BaseNavgationViewController *loginNavi =[[BaseNavgationViewController alloc] initWithRootViewController:[BaseLogInViewController new]];
        CATransition *anima = [CATransition animation];
        anima.type = @"fade";//设置动画的类型
        anima.subtype = kCATransitionFromRight; //设置动画的方向
        anima.duration = 0.3f;
        
        self.window.rootViewController = loginNavi;
        
        [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
    }
}
//网络状态变化
- (void)netWorkStateChange:(NSNotification *)notification
{
    BOOL isNetWork = [notification.object boolValue];
    if (isNetWork) {//有网络
        
    } else {//登陆失败
        
    }
    
}


//网络状态监听
- (void)monitorNetworkStatus
{
    [BaseNetWorkServers networkStatusWithBlock:^(NetworkStatusType status) {
        switch (status) {
            case NetworkStatusTypeUnknown:
            {
                DLog(@"网络环境：未知网络");
                KPostNotification(KNotificationNetWorkStateChange, @NO);
            }
                break;
            case NetworkStatusTypeNotReachable:
            {
                DLog(@"网络环境：无网络");
                KPostNotification(KNotificationNetWorkStateChange, @NO);
            }
                break;
            case NetworkStatusTypeReachableViaWWAN:
            {
                DLog(@"网络环境：手机网络");
                KPostNotification(KNotificationNetWorkStateChange, @YES);
            }
                break;
            case NetworkStatusTypeReachableViaWIFI:
            {
                DLog(@"网络环境：WiFi");
                
                KPostNotification(KNotificationNetWorkStateChange, @YES);
            }
                break;
                
            default:
                break;
        }
    }];
}

@end
