//
//  NSString+TXMD5.m
//  ShopMobile
//
//  Created by chenxiaojie on 2019/3/18.
//  Copyright © 2019年 soubao. All rights reserved.
//

#import "NSString+TXMD5.h"
#import "CommonCrypto/CommonDigest.h"

@implementation NSString (TXMD5)

+ (NSString *)md5:(NSString *)inputStr {
    const char *cStr = [inputStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (NSString *)dencodeBase64:(NSString *)base64String {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)encodeBase64:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    return [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
}

@end
