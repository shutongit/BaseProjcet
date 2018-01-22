//
//  GYDes.h
//  IdealMobileOffice
//
//  Created by guzhiyang on 15/12/23.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYDes : NSObject

// 把一个byte数据转换为字符串
+(NSString *) parseByte2HexString:(Byte *) bytes;
// 把一个byte数组转换为字符串
+(NSString *) parseByteArray2HexString:(Byte[]) bytes;

// nsData 转16进制
+ (NSString*)stringWithHexBytes2:(NSData *)sender;

/****** 加密 ******/
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
/****** 解密 ******/
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;

+ (NSString *)encryptUseDES:(NSString *)plainText andKey:(NSString *)authKey andIv:(NSString *)authIv;

+ (NSString *)decryptUseDES:(NSString *)plainText andKey:(NSString *)authKey andIv:(NSString *)authIv;


@end
