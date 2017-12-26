//
//  BaseUserManager.m
//  BaseProject
//
//  Created by 舒通 on 2017/9/1.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseUserManager.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation BaseUserManager
//单利
SINGLETON_FOR_CLASS(BaseUserManager)

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        //被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKick) name:KNotificationOnKick object:nil];
    }
    return self;
}
//加载缓存的用户信息
- (BOOL)loadUserInfo
{
    NSDictionary *param = [[NSUserDefaults standardUserDefaults] objectForKey:KUserModelCache];
    if (ValidDict(param)) {
        self.curUserInfo = [BaseUserInfo mj_objectWithKeyValues:param];
        return YES;
    } else {
        return NO;
    }
}
//退出登录
- (void)logout:(loginBlock)completion
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    self.isLogined = NO;
    self.curUserInfo = nil;
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:KUserModelCache];
    [[NSUserDefaults standardUserDefaults] synchronize];
    KPostNotification(KNotificationLoginStateChange, @NO);
}
#pragma mark  ************** 登陆 **************
//三方登陆
- (void)login:(UserLoginType)loginType completion:(loginBlock)completion
{
    [self login:loginType params:nil completion:completion];
}

//带参登录
- (void)login:(UserLoginType)loginType params:(NSDictionary *)param completion:(loginBlock)completion
{
    //三方登录
    if (loginType != UserLoginTypePwd) {
        //友盟登录类型
        UMSocialPlatformType platFormType;
        if (loginType == UserLoginTypeQQ) {
            platFormType = UMSocialPlatformType_QQ;
        } else if (loginType == UserLoginTypeWeChat) {
            platFormType = UMSocialPlatformType_WechatSession;
        } else {
            platFormType = UMSocialPlatformType_UnKnown;
        }
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platFormType currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                completion(NO,error.localizedDescription);
            } else {
                UMSocialUserInfoResponse *resp = result;
                NSDictionary *params = @{@"openid":resp.openid, @"nickname":resp.name, @"photo":resp.iconurl, @"sex":[resp.unionGender isEqualToString:@"男"]?@1:@2, @"cityname":resp.originalResponse[@"city"], @"fr":@(loginType)};
                self.loginType = loginType;
                [self loginToServer:params completion:completion];
            }
        }];
        
    } else {
        DLog(@"授权失败");
    }
}
#pragma mark ————— 手动登录到服务器 —————
-(void)loginToServer:(NSDictionary *)params completion:(loginBlock)completion{
    
    [BaseNetWorkServers POST:NSStringFormat(@"%@%@",URL_main,URL_user_login) parameters:params success:^(id responseObject) {
        [self loginSuccess:responseObject completion:completion];
        
    } failure:^(NSError *error) {
        if (completion) {
            completion(NO,error.localizedDescription);
        }
    }];
}
#pragma mark  ************** private method **************

//登陆结果处理
- (void)loginSuccess:(id)responseObject completion:(loginBlock)completion
{
    if (ValidDict(responseObject)) {
        if (ValidDict(responseObject[@"data"])) {
            NSDictionary *data = responseObject[@"data"];
            self.curUserInfo = [BaseUserInfo mj_objectWithKeyValues:data];
            [self saveUserInfo:data];
            self.isLogined = YES;
            if (completion) {
                completion(YES,nil);
            }
            KPostNotification(KNotificationLoginStateChange, @YES);
        } else {
            self.isLogined = NO;
            self.curUserInfo = nil;
            if (completion) {
                completion(NO,nil);
            }
            KPostNotification(KNotificationLoginStateChange, @NO);
        }
    } else {
        self.isLogined = NO;
        self.curUserInfo = nil;
        if (completion) {
            completion(NO,nil);
        }
        KPostNotification(KNotificationLoginStateChange, @NO);
    }
}
//存储用户信息
- (void)saveUserInfo:(NSDictionary *)param
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:KUserModelCache];
    if (ValidDict(dic)) {
        [dict addEntriesFromDictionary:dic];
    }
    if (ValidDict(param)) {
        [dict addEntriesFromDictionary:param];
        
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:KUserModelCache];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.curUserInfo = [BaseUserInfo mj_objectWithKeyValues:param];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:KUserModelCache];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//下线
-  (void)onKick
{
    [self logout:nil];
}

- (void)savePhone:(NSString *)phone
{
    NSDictionary *param = [[NSUserDefaults standardUserDefaults] objectForKey:KUserModelCache];
    if (ValidDict(param)) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:param];
        [dict setObject:phone forKey:@"phone"];
        [self saveUserInfo:dict];
    }
}
- (void)saveBirthday:(NSString *)birthday
{
    NSDictionary *param = [[NSUserDefaults standardUserDefaults] objectForKey:KUserModelCache];
    if (ValidDict(param)) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:param];
        [dict setObject:birthday forKey:@"birthday"];
        [self saveUserInfo:dict];
    }
}
- (void)saveNickName:(NSString *)nickName
{
    NSDictionary *param = [[NSUserDefaults standardUserDefaults] objectForKey:KUserModelCache];
    if (ValidDict(param)) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:param];
        [dict setObject:nickName forKey:@"nickname"];
        [self saveUserInfo:dict];
    }
}
- (void)saveSex:(UserGender)gender
{
    NSDictionary *param = [[NSUserDefaults standardUserDefaults] objectForKey:KUserModelCache];
    if (ValidDict(param)) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:param];
        [dict setObject:@(gender) forKey:@"sex"];
        [self saveUserInfo:dict];
    }
}

@end
