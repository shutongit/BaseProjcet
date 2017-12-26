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
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure {
    
    NSString *urlString = [self DictionaryConversionJson:parameters];

    NSURLSessionTask *sessionTask = [_sessionManager POST:[NSString stringWithFormat:@"%@/%@",URL,urlString] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[self allSessionTask]removeObject:task];
//        [SoapXmlParseHelper rootNodeToString:responseObject]
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
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data {
    if(data == nil) { return nil; }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted | NSJSONReadingMutableContainers error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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
