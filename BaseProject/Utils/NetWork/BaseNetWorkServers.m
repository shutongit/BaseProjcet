//
//  BaseNetWorkServers.m
//  BaseProject
//
//  Created by 舒通 on 2017/8/31.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import "BaseNetWorkServers.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AESCommonCrypto.h"
#import "SvUDIDTools.h"
#import "GYDes.h"

#define Ciphertext @"btO5OxUEelfxA63YVmI28pkKUM6+//9BAbg7eWE2aXkpunug4GlMZA=="
#define DESKEY @"w86GhD2qCJAE959MKLrcEz1JRKL08Qwb"
#define DESIV @"01234567"

@implementation BaseNetWorkServers
/**
 存储着所有的请求task数组
 */
static NSMutableArray *_allSessionTask;

static AFHTTPSessionManager *_sessionManager;


#pragma mark  ************** 开始监听网络 **************
+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(NetworkStatusTypeUnknown) : nil;
                    DLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(NetworkStatusTypeNotReachable) : nil;
                    DLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(NetworkStatusTypeReachableViaWWAN) : nil;
                    DLog(@"手机自带网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(NetworkStatusTypeReachableViaWIFI) : nil;
                    DLog(@"WIFI");
                    break;
            }
 
        }];
    });
}
// GET 请求
+ (NSURLSessionTask *)GET:(NSString *)URL parameters:(id)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure
{
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"responseObject = %@",[self jsonToString:responseObject]);
        [[self allSessionTask]removeObject:task];
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"responseObject = %@",[self jsonToString:error]);
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    sessionTask ? [[self allSessionTask]addObject:sessionTask] : nil;
    return sessionTask;
}
// POST 请求
+ (NSURLSessionTask *)POST:(NSString *)methodName
                        requestUrl: (NSString *)requestUrl
                        parameters:(id)parameters
                        success:(HttpRequestSuccess)success
                        failure:(HttpRequestFailed)failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [params setObject:requestUrl forKey:@"requestKey"];
    NSString *urlString = [self jsonToDictionary:params];
    urlString = [self addTerminalElementFromJsonString:urlString];
    
    //加密
    NSString *DESKey = [GYDes decryptUseDES:Ciphertext andKey:DESKEY andIv:DESIV];
    urlString = [GYDes encryptUseDES:urlString andKey:DESKey andIv:DESIV];
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:[NSString stringWithFormat:@"%@",methodName] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask]removeObject:task];
        NSString *resuleStr = [self jsonToString:responseObject];
        DLog(@"responseObject = %@",resuleStr);
        NSData *resultData = [resuleStr dataUsingEncoding:NSUTF8StringEncoding];
        if (resuleStr.length == 0 || [NSString isBlankString:resuleStr]) {
            return ;
        }
        NSMutableDictionary *resultDic =  [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
        //解密
        NSString *str;
        if ([[resultDic allKeys]containsObject:@"Info"]) {
            
            str = [AESCommonCrypto decryptAESData:[resultDic objectForKey:@"Info"]];
        }
        str = [str stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
        NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        success ? success(dictionary) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allSessionTask] removeObject:task];
        
        failure ? failure(error) : nil;
    }];
    sessionTask ? [[self allSessionTask]addObject:sessionTask] : nil;
    return sessionTask;
}


//取消所有网络请求
+ (void)cancelAllRequest
{
    //锁操作
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}
//取消指定URL的HTTP请求
+ (void)cancelRequestWithURL:(NSString *)URL
{
    if (!URL) {
        return;
    }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [obj cancel];
                [[self allSessionTask]removeObject:obj];
                *stop = YES;
            }
        }];
    }
}

/**
 加密

 @param Dictionary 参数字典
 @return 加密内容
 */
+ (NSString *)DictionaryConversionJson:(NSDictionary *)Dictionary
{
    NSError *parseError = nil;
    NSString *jsonStr = @"";
    if ([Dictionary isKindOfClass:[NSDictionary class]]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Dictionary options:NSJSONWritingPrettyPrinted error:&parseError];
        jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonStr = [AESCommonCrypto encryptAESData:jsonStr];
    }
    return jsonStr;
}

/**
 字典转字符串

 @param dictionary 字典
 @return return value description
 */
+ (NSString *)jsonToDictionary:(NSDictionary *)dictionary
{
    NSError *parseError = nil;
    NSString *jsonStr = @"";
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];
        jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonStr;
}

/**
 Json字符串转字典

 @param JSONString JSONString description
 @return return value description
 */
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data {
    if(data == nil) { return nil; }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted | NSJSONReadingMutableContainers error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//添加设备参数
+ (NSString *)addTerminalElementFromJsonString:(NSString *)requestString{
    
    NSMutableDictionary *Jsondic = [[NSMutableDictionary alloc] initWithDictionary:[self parseJSONStringToNSDictionary:requestString]];//[requestString objectFromJSONString]
    //设备分辨率
    [Jsondic setObject:[NSString stringWithFormat:@"%.0f*%.0f",KScreenWidth,KScreenHeight] forKey:@"terminalResolution"];
    //设备类型
    [Jsondic setObject:[[UIDevice currentDevice] model] forKey:@"terminalName"];
    //设备号
    [Jsondic setObject:[SvUDIDTools UDID]?[SvUDIDTools UDID]:@""  forKey:@"terminalKey"];
    //系统版本号
    NSString *systemVersion = @"";
    systemVersion = [[[NSProcessInfo processInfo] operatingSystemVersionString] substringToIndex:[[[NSProcessInfo processInfo] operatingSystemVersionString] rangeOfString:@"（"].location];
    
    [Jsondic setObject:systemVersion forKey:@"terminalCode"];
    //应用版本号
    [Jsondic setObject:@"" forKey:@"systemCode"];
    return [self jsonToDictionary:Jsondic];// [Jsondic JSONString];
}
#pragma mark  ************** 判断网络类型 **************  

+ (BOOL)isNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}
+ (BOOL)isWWANNetwork
{
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWWAN];
}
+ (BOOL)isWiFiNetwork
{
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
}

#pragma mark  ************** setter /getter **************
+ (NSMutableArray *)allSessionTask
{
    if (!_allSessionTask) {
        _allSessionTask = [NSMutableArray arrayWithCapacity:0];
    }
    return _allSessionTask;
}
#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间
    _sessionManager.requestSerializer.timeoutInterval = 30.f;
    
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    //    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/encode", nil];
//    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

@end
