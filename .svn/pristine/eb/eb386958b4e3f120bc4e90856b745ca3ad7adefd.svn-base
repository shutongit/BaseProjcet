//
//  BaseUserManager.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/1.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUserInfo.h"


typedef NS_ENUM(NSUInteger, UserLoginType) {
    UserLoginTypeUnknow = 0,//未知
    UserLoginTypeWeChat,//微信登陆
    UserLoginTypeQQ,//QQ登录
    UserLoginTypePwd,//账号登陆
};

#define isLogin [BaseUserManager sharedBaseUserManager].isLogined
#define curUser [BaseUserManager sharedBaseUserManager].curUserInfo
#define userManager [BaseUserManager sharedBaseUserManager]

typedef void (^loginBlock)(BOOL success, NSString *des);

/**
 包含用户相关服务
 */
@interface BaseUserManager : NSObject
//单利
SINGLETON_FOR_HEADER(BaseUserManager)
//当前用户
@property (nonatomic, strong) BaseUserInfo *curUserInfo;
@property (nonatomic, assign) UserLoginType loginType;
@property (nonatomic, assign) BOOL isLogined;

#pragma mark  ************** 登陆相关 **************

/**
 三方登陆

 @param loginType 登陆方式
 @param completion 回调
 */
- (void)login:(UserLoginType)loginType completion:(loginBlock)completion;

/**
 带参登陆

 @param loginType 登陆方式
 @param param 参数
 @param completion 回调
 */
- (void)login:(UserLoginType)loginType params:(NSDictionary *)param completion:(loginBlock)completion;

/**
 自动登录

 @param completion 回调
 */
//- (void)autoLoginToServer:(loginBlock)completion;

/**
 退出登录

 @param completion 回调
 */
- (void)logout:(loginBlock)completion;

/**
 加载缓存用户数据

 @return 是否成功
 */
- (BOOL)loadUserInfo;

/**
 保存数据

 @param param 数据源
 */
- (void)saveUserInfo:(NSDictionary *)param;

/**
 保存电话

 @param phone phone description
 */
- (void)savePhone:(NSString *)phone;

/**
 保存生日

 @param birthday birthday description
 */
- (void)saveBirthday:(NSString *)birthday;

/**
 保存昵称

 @param nickName nickName description
 */
- (void)saveNickName:(NSString *)nickName;

/**
 保存性别

 @param gender gender description
 */
- (void)saveSex:(UserGender)gender;

@end
