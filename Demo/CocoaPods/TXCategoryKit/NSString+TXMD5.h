//
//  NSString+TXMD5.h
//  ShopMobile
//
//  Created by chenxiaojie on 2019/3/18.
//  Copyright © 2019年 soubao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TXMD5)

+ (NSString *)md5:(NSString *)inputStr;

/** base64解码 */
+ (NSString *)dencodeBase64:(NSString *)base64String;

/** base64编码*/
+ (NSString *)encodeBase64:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
