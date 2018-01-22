//
//  EncryptUtil.h
//  SpriteTest
//
//  Created by Kingtas on 13-5-10.
//
//

#import <Foundation/Foundation.h>

@interface EncryptUtil : NSObject

+(NSString *) encryptWithData:(NSData *) data;
+(NSString *) decryptWithData:(NSData *) data;


+(NSString *) encryptWithString:(NSString *) str;
+(NSString *) decryptWithString:(NSString *) str;

+ (NSString *)encryptWithText:(NSString *)sText;
+ (NSString *)decryptWithText:(NSString *)sText;
@end
