//
//  BaseNetWorkServers.h
//  BaseProject
//
//  Created by 舒通 on 2017/8/31.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//#ifndef kIsNetWork
//#define kIsNetWork


typedef NS_ENUM(NSUInteger, NetworkStatusType) {
    
    //未知网络
    NetworkStatusTypeUnknown,
    //无网络
    NetworkStatusTypeNotReachable,
    //手机网络
    NetworkStatusTypeReachableViaWWAN,
    //WIFI网络
    NetworkStatusTypeReachableViaWIFI
};

/**
 通用callBack

 @param success 接口是否请求成功
 @param responseObject 返回数据
 @param error 错误信息
 */
typedef void(^HttpRequestCallBack)(BOOL success, id responseObject, NSError *error);

/**
 请求成功block

 @param responseObject 返回数据
 */
typedef void(^HttpRequestSuccess)(NSDictionary *responseObject);


/**
 请求失败block

 @param error 错误信息
 */
typedef void(^HttpRequestFailed)(NSError *error);


/**
 上传或者下载的进度

 @param progress Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
 */
typedef void(^HttpProgress)(NSProgress *progress);


/**
 网络状态的block

 */
typedef void(^NetworkStatus)(NetworkStatusType status);


@class AFHTTPSessionManager;

@interface BaseNetWorkServers : NSObject

/**
 是否有网络

 @return yes 有网，no 没网
 */
+ (BOOL)isNetwork;

/**
 是否是手机网络

 @return yes 是， no 不是
 */
+ (BOOL)isWWANNetwork;

/**
 是否是wifi

 @return yes 是，no 不是
 */
+ (BOOL)isWiFiNetwork;


/**
 取消所有HTTP请求
 */
+ (void)cancelAllRequest;


/**
 监听网络状态

 @param networkStatus 网络状态
 */
+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus;

/**
 取消指定URL的HTTP请求
 */
+ (void)cancelRequestWithURL:(NSString *)URL;


/**
 GET请求

 @param URL 请求地址
 @param parameters 请求参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(id)parameters
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailed)failure;
/**
 POST请求
 
 @param requestUrl 请求地址
 @param parameters 请求参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)POST:(NSString *)methodName
                requestUrl: (NSString *)requestUrl
                parameters:(id)parameters
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure;

@end
