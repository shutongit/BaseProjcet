//
//  BaseAppManager.h
//  BaseProject
//
//  Created by 舒通 on 2017/9/4.
//  Copyright © 2017年 舒通. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseAppManager : NSObject

/**
 加载广告
 */
+ (void)appStartAdver;

/**
 计算缓存

 @return 缓存大小
 */
+ (float)readCacheSize;

/**
 清理缓存
 */
+ (void)clearFile;


@end
