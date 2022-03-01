//
//  TXCommonUtils.h
//  LYHM
//
//  Created by chenxiaojie on 2019/8/23.
//  Copyright © 2019 chenxiaojie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TXCommonUtils : NSObject

/**
 @brief 获取当前本地时间
 */
+ (NSString *)getCurrTimeTimestamp;

/**
 @brief 通过 key 保存本地时间戳
 @param key     保存时间戳的key
*/
+ (void)saveLocalCurrTimeWithKey:(NSString *)key;

/**
 @brief 通过 key 计算此时时间戳与时间记录时间戳差值（单位秒）
 @param key     保存时间戳的key
*/
+ (NSTimeInterval)getLocalTimeDifferenceWithKey:(NSString *)key;

/**
 @brief 时间戳转字符串
 @param timeStamp   时间戳
 @param formatter   时间格式
 */
+ (NSString *)getTimeStrFromTimeStamp:(double)timeStamp withFormatter:(NSString *)formatter;

/**
 @brief 获取随机数字和字母
 @param num     需要生成随机个数
 */
+ (NSString *)getRandomStringWithNum:(NSInteger)num;

/**
 @brief 获取随机数字和字母
 @param from     需要生成随机个数 from
 @param to       需要生成随机个数 to
 */
+ (NSString *)getRandomStringWithFrom:(NSInteger)from to:(NSInteger)to;

+ (NSString *)getIDFA;

+ (NSString *)getUUID;

+ (BOOL)isUserNotificationEnable;
+ (void)goToAppSystemSetting;

/**
 @brief 添加 Label 中划线
 @param textStr		label.text
 */
+ (NSAttributedString *)formateLabelLineWithStr:(NSString *)textStr;

/**
 @brief 添加 Label 中划线，拼接前缀“官方价”
 @param suffixStr       价格前缀
 @param priceStr        具体价格
 */
+ (NSAttributedString *)formateLabelLineWithSuffixStr:(NSString *)suffixStr priceStr:(NSString *)priceStr;
+ (NSAttributedString *)formateLabelLineWithSuffixStr:(NSString *)suffixStr priceStrAttr:(NSAttributedString *)priceStrAttr;
/**
 @brief 压缩图片
 @param image			image
 @param maxFileSize		maxFileSize
 */
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;

+ (NSString *)htmlEntityDecode:(NSString *)string;

/**
 @brief 从 url 获取请求参数
 @param urlStr          urlStr
 @return 请求参数字典
 */
+ (NSDictionary *)parameterWithURLstr:(NSString *)urlStr;

/**
@brief 网络图片或者 gif 下载
@param url                          网络目标 需要下载 url
@param successBlock      保存本地
*/
+ (void)downloadPic:(NSString *)url successBlock:(void(^)(NSString * filepath))successBlock;

@end

NS_ASSUME_NONNULL_END
