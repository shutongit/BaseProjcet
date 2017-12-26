//
//  NSString+Extension.m
//  SKKit
//
//  Created by maxin on 16/5/7.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import "NSString+Extension.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation NSString (Extension)
//移除空格
-(NSString *)removeWhiteSpace
{
    NSString *resultStr=@"";
    NSArray *arr=[self componentsSeparatedByString:@" "];
    for (NSString *str in arr)
    {
        resultStr = [resultStr stringByAppendingString:str];
    }
    return resultStr;
}
//移除短线
-(NSString *)removeWhiteline
{
    NSString *resultStr=@"";
    NSArray *arr=[self componentsSeparatedByString:@"-"];
    for (NSString *str in arr)
    {
        resultStr = [resultStr stringByAppendingString:str];
    }
    return resultStr;
}
-(NSString *)formatNumber{

    if( ![self isPureIntStr] || ![self isPureFloatStr]){
    
        return self;
    }else{
    
        if ([self floatValue]>10000) {
            return [NSString stringWithFormat:@"%.1f万",[self floatValue]/10000];
        }else{
        
            return [NSString stringWithFormat:@"%@",self];
        }
    }
  return self;
}

- (BOOL)isPureIntStr{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

- (BOOL)isPureFloatStr{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//手机号码验证。YES 是手机号
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13，14， 15，17,18开头，八个 \d 数字字符
    NSString *phoneRegex = @"(^1[3|4|5|7|8][0-9]{9}$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

// 计算文字宽高
+(CGSize)getStringSize:(float)fontSize withString:(NSString*)str andWidth:(CGFloat)width
{
    return [str boundingRectWithSize:CGSizeMake(width, LONG_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}


//用户名
+ (BOOL) validateUserName:(NSString *)name{
    
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:name];
    
}

//密码
+ (BOOL) validatePassword:(NSString *)passWord{
    
    NSString *passWordRegex = @"^(?![0-9]+$)(?![A-Za-z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
    
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard{
    
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


//格式化时间
+(NSString *)fomartDate:(NSString *)Date{
    long long time=[Date doubleValue];
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSString *dateString = [dateFormat stringFromDate:nd];
    return dateString;
}

/**
 * 安全获取字符串
 * @param mStr 字符串
 * @returns 若字符串为nil，则返回@""，否则直接返回字符串
 */
+ (NSString *)strOrEmpty:(NSString *)mStr {
    return (!mStr || [mStr class] == [NSNull class] ) ? @"": mStr;
}


// 生成随机订单ID
+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((int)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

//获取手机IP
+ (NSString *)getPhoneIP {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    if ([address isEqualToString:@"error"])
    {
        address = @"192.168.1.1";
    }
    return address;
    
}
//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
//第一次进App
+ (BOOL)isFirstTimeEnterApp
{
    static NSString *fristTimeEnterAppKey = @"fristTimeEnterAppKey";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults objectForKey:fristTimeEnterAppKey])
    {
        return (NO);
    }
    [userDefaults setValue:@"" forKey:fristTimeEnterAppKey];
    return (YES);
}

/**
 *  MD5 加密字符串
 */
+ (NSString *)MD5NSString:(NSString *)string{
    
    if (string == nil || [string length] == 0) {
        return nil;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
    
}

/**
 *  判断字符串是否为空
 */

+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
//判断是否为弱密码
-(BOOL)weakPswd{
    NSString *pswdEx =@"^(?=.*\\d.*)(?=.*[a-zA-Z].*).{6,20}$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pswdEx];
    return [regExPredicate evaluateWithObject:self];
}
//string转date
+ (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];

    NSDate *destDate= [dateFormatter dateFromString:dateString];

    
    return destDate;
    
}
// 汉字转拼音
+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    return [pinyin uppercaseString];
}

#pragma  mark - 验证银行卡
+(BOOL)isValidCardNumber:(NSString *)cardNumber
{
    NSString *digitsOnly = [self getDigitsOnly:cardNumber];
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (int i = digitsOnly.length  - 1.0; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}
//判断是否银行卡
+ (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;    //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    //妈蛋对于 2245678 这个数字我无语了 这个算法解决不了他了，所以我就加个长度判断了～～
    if (cardNoLength < 16 || cardNoLength > 19) {
        return NO;
    }
    
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) ==0)
        return YES;
    else
        return NO;
}
+(NSString *)getDigitsOnly:(NSString*)s{
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < s.length; i++)
    {
        c = [s characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    return digitsOnly;
}

@end

