//
//  BaseHelper.h
//  BaseProject
//
//  Created by 舒通 on 2017/8/30.
//  Copyright © 2017年 舒通. All rights reserved.
//


#ifndef BaseHelper_h

/**
 基本宏定义
 */
#define BaseHelper_h

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//系统版本
//判断是在iOS11之前
#ifndef kiOS11Before
#define kiOS11Before ([UIDevice systemVersion] < 11)
#endif

#ifndef kSystemVersion
#define kSystemVersion [UIDevice systemVersion]
#endif


#ifndef kiOS6Later
#define kiOS6Later ([UIDevice systemVersion] >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later ([UIDevice systemVersion] >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later ([UIDevice systemVersion] >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later ([UIDevice systemVersion] >= 9)
#endif

//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//获取屏幕宽高
#define KScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreen_Bounds [UIScreen mainScreen].bounds

#define Iphone6ScaleWidth KScreenWidth/375.0
#define Iphone6ScaleHeight KScreenHeight/667.0
//根据ip6的屏幕来拉伸
#define kRealValue(with) ((with)*(KScreenWidth/375.0f))

//强弱引用
#define kWS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define kSS(strongSelf) __strong __typeof(&*weakSelf)strongSelf = weakSelf;

//导航栏高度
#define NavHeight 64.0f
#define TabHeight 49.0f

///IOS 版本判断
#define IOSAVAILABLEVERSION(version) ([[UIDevice currentDevice] availableVersion:version] < 0)
// 当前系统版本
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
//当前语言
#define CurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])


//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//定义UIImage对象
#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]
#define IMAGE_NAMED(name) [UIImage imageNamed:name]

//数据验证
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")
#define HasString(str,key) ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])


// 设置view的圆角和边框
#define BSViewsBorder(View,radius,width,color)\
\
[View.layer setCornerRadius:(radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(width)];\
[View.layer setBorderColor:[color CGColor]];


//打印当前方法名
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

//打印Log
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG 
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;
//单利
#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#endif /* BaseHelper_h */
