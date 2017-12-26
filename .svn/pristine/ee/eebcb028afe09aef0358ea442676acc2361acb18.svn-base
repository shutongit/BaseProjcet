//
//  NSString+Extension.h
//  SKKit
//
//  Created by maxin on 16/5/7.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString (Extension)
/**
 移除空格

 @return return value description
 */
-(NSString *)removeWhiteSpace;

-(NSString *)removeWhiteline;


-(NSString *)formatNumber;

//是否是数字
- (BOOL)isPureIntStr;
//判断是否为浮点形：
- (BOOL)isPureFloatStr;

/**
 获取字符串的size

 @param fontSize fontSize description
 @param str str description
 @param width width description
 @return return value description
 */
+(CGSize)getStringSize:(float)fontSize withString:(NSString*)str andWidth:(CGFloat)width;


/**
 邮箱

 @param email email description
 @return return value description
 */
+ (BOOL) validateEmail:(NSString *)email;

/**
 手机号码验证

 @param mobile mobile description
 @return return value description
 */
+ (BOOL) validateMobile:(NSString *)mobile;

/**
 *  用户名
 *
 *  @param name name description
 *
 *  @return return value description
 */
+ (BOOL) validateUserName:(NSString *)name;


/**
 *  //密码
 *
 *  @param passWord passWord description
 *
 *  @return return value description
 */
+ (BOOL) validatePassword:(NSString *)passWord;


/**
 *  //昵称
 *
 *  @param nickname nickname description
 *
 *  @return return value description
 */
+ (BOOL) validateNickname:(NSString *)nickname;


/**
 *  //身份证号
 *
 *  @param identityCard identityCard description
 *
 *  @return return value description
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/**
 *  //格式化时间时间
 *
 *  @param Date value description
 *
 *  @return value description
 */
+(NSString *)fomartDate:(NSString *)Date;


/**
 * 安全获取字符串
 * @param mStr 字符串
 * @returns 若字符串为nil，则返回@""，否则直接返回字符串
 */
+ (NSString *)strOrEmpty:(NSString *)mStr;

/**
 *  // 生成随机订单ID
 *
 *  @return value description
 */
+ (NSString *)generateTradeNO;

/**
 *
 *  //获取手机IP
 *  @return value description
 */
+ (NSString *)getPhoneIP;

/**
 *  //第一次进App
 *
 *  @return value description
 */
+ (BOOL)isFirstTimeEnterApp;

/**
 *  MD5 加密字符串
 */
+ (NSString *)MD5NSString:(NSString *)string;

/**
 *  判断字符串是否为空
 */
+(BOOL) isBlankString:(NSString *)string;
/**
 *  弱密码判断
 */
-(BOOL)weakPswd;
/**
 *  string转nsdate
 */
+ (NSDate *)dateFromString:(NSString *)dateString;

// 汉字转拼音
+ (NSString *)transform:(NSString *)chinese;

+ (BOOL)isPureFloat:(NSString*)string;

/**
 *  判断银行卡号是否正确  剔除卡号里的非法字符  检查银行卡是否合法
 */
+(BOOL)isValidCardNumber:(NSString *)cardNumber;

+ (BOOL) checkCardNo:(NSString*) cardNo;
@end
