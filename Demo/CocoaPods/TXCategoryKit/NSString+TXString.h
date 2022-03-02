//
//  NSString+TXString.h
//  Autoyol
//
//  Created by Ning Gang on 14/11/17.
//  Copyright (c) 2014年 Atzuche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (TXString)

/**
 @brief 字符串转字典
 @param jsonString   json字符串
 @return NSDictionary
 */
+ (NSDictionary *)dictionaryWithJSONString:(NSString *)jsonString;
+ (NSString *)convertToJsonData:(NSDictionary *)dict;
/**
 @brief 数组转json
 @param array       array
 @return            string
 */
+ (NSString *)strWithFormatWithAry:(NSArray *)array;

- (NSString *)URLEncodedString;

- (BOOL)isGetter;
- (BOOL)isSetter;

- (NSString *)getterToSetter;
- (NSString *)setterToGetter;
//带日期的字符串转化为Date格式
-(NSDate *)stringChangeToDate;
//字符串中得到周几
- (NSString *) countWeekDays;
//日期返回带年月日的日期字符串
-(NSString *)changeStringToDate;

//字符串中得到周几
- (NSUInteger) getWeekDay:(NSString *)format;

//是否是月初一天
-(BOOL)isFirstDayOfMonth:(NSString *)format;
//是否是月末一天
-(BOOL)isLastDayOfMonth:(NSString *)format;
/**
 金额千分位分割（）
 @param text 金额
 @return 格式化后的金额
 */
// 获取这个字符串ASting中的所有abc的所在的index
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText;
/**
 金额千分位分割

 @param moneyTxt 金额
 @param isHasDecimal 是否显示小数后两位
 @return 格式化后的金额
 */
+ (NSString *)moneyThousandsFormat:(NSString *)moneyTxt  isHasDecimal:(BOOL)isHasDecimal;
/**
 *  计算文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *
 *  @return 占用的宽高
 */

-(CGSize)sizeWithFont:(UIFont*)font maxSize:(CGSize)maxSize;

//求有行间距的label高度
+ (CGSize)boundingRectWithSize:(CGSize)size WithStr:(NSString*)string andFont:(UIFont *)font andLinespace:(CGFloat)space;

/** !
 * @brief 循环遍历获取所有分词并记录到数组中
 * @param string 要分词的字符串
 * @return NSArray 获取分词数组
 */
+(NSArray*)getStringTokenizerWithStr:(NSString*)string;


//变速箱类型  ---  1：手动  2：自动
+ (NSString *)convertGearboxToText:(NSString *)string;
+ (NSString *)convertGearboxToDigit:(NSString *)string;

//车门数 --- 1、2、3 分别代表 两门、四门、六门
+ (NSString *)convertDoorNumToText:(NSString *)string;
+ (NSString *)convertDoorNumToDigit:(NSString *)string;


//座位数 --- 2-7、8为7座以上
+ (NSString *)convertSeatNumToText:(NSString *)string;
+ (NSString *)convertSeatNumToDigit:(NSString *)string;


//真皮座椅  ---  1：有  3：无
+ (NSString *)convertSeatTypeToText:(NSString *)string;
+ (NSString *)convertSeatTypeToDigit:(NSString *)string;

//天窗配置  ---  1：无  2：有  3：全景  4：敞篷
+ (NSString *)convertSkylightsTypeToText:(NSString *)string;
+ (NSString *)convertSkylightsTypeToDigit:(NSString *)string;


//倒车辅助  ---  1：无  2：倒车雷达  3：倒车影像
+ (NSString *)convertRadarToText:(NSString *)string;
+ (NSString *)convertRadarToDigit:(NSString *)string;


//驱动方式  ---  1：两驱  2：四驱
+ (NSString *)convertDriveTypeToText:(NSString *)string;
+ (NSString *)convertDriveTypeToDigit:(NSString *)string;



@end
