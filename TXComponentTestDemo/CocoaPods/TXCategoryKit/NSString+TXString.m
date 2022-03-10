//
//  NSString+TXString.m
//  Autoyol
//
//  Created by Ning Gang on 14/11/17.
//  Copyright (c) 2014年 Atzuche. All rights reserved.
//

#import "NSString+TXString.h"

@implementation NSString (TXString)

+ (NSDictionary *)dictionaryWithJSONString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dict;
}

+ (NSString *)convertToJsonData:(NSDictionary *)dict {
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+ (NSString *)strWithFormatWithAry:(NSArray *)array {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:&error];
    
    if (!jsonData) {
        NSLog(@"%@",error);
        return nil;
    }else{
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    
}

- (NSString *)URLEncodedString {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

- (BOOL)isGetter {
    
    return ![self isSetter];
}


- (BOOL)isSetter {
    
    return [self hasPrefix:@"set"];
}


- (NSString *)getterToSetter {
    
    NSRange firstChar, rest;
    firstChar.location  = 0;
    firstChar.length    = 1;
    rest.location       = 1;
    rest.length         = self.length - 1;
    
    return [NSString stringWithFormat:@"set%@%@:",
            [[self substringWithRange:firstChar] uppercaseString],
            [self substringWithRange:rest]];
}


- (NSString *)setterToGetter {
    
    NSRange firstChar, rest;
    firstChar.location  = 3;
    firstChar.length    = 1;
    rest.location       = 4;
    rest.length         = self.length - 5;
    
    return [NSString stringWithFormat:@"%@%@",
            [[self substringWithRange:firstChar] lowercaseString],
            [self substringWithRange:rest]];
}
//字符串格式转化为日期
-(NSDate *)stringChangeToDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    formatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [formatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    NSDate *date=[formatter dateFromString:self];
    return date;
}

- (NSUInteger) getWeekDay:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    formatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [formatter setDateFormat:format];
    NSDate *date=[formatter dateFromString:self];
    
    NSCalendar*calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents*comps;
    
    comps =[calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday |NSCalendarUnitWeekdayOrdinal)
                       fromDate:date];
    return [comps weekday];
}

-(BOOL)isFirstDayOfMonth:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    formatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [formatter setDateFormat:format];
    NSDate *newDate=[formatter dateFromString:self];
    
    double interval = 0;
    NSDate *firstDate = nil;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    if ([calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate]) {
        return [self isEqualToString:[formatter stringFromDate:firstDate]];
    }else {
        return NO;
    }
}

-(BOOL)isLastDayOfMonth:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    formatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [formatter setDateFormat:format];
    NSDate *newDate=[formatter dateFromString:self];

    double interval = 0;
    NSDate *firstDate = nil;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    if ([calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate]) {
        return [self isEqualToString:[formatter stringFromDate:[firstDate dateByAddingTimeInterval:interval - 1]]];
    }else {
        return NO;
    }
}
//字符串中得到周几
- (NSString *) countWeekDays
{
    NSCalendar*calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents*comps;
    
    comps =[calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday |NSCalendarUnitWeekdayOrdinal)
                       fromDate:[self stringChangeToDate]];
    
    if ([comps weekday]==1) {
        return @"周日";
    }
    else if ([comps weekday]==2) {
        return @"周一";
    }
    else if([comps weekday]==3) {
        return @"周二";
    }
    else if ([comps weekday]==4) {
        return @"周三";
    }
    else if ([comps weekday]==5) {
        return @"周四";
    }
    else if ([comps weekday]==6) {
        return @"周五";
    }
    else  {
        return @"周六";
    }
}
-(NSString *)changeStringToDate
{
    NSString *str1=[self substringWithRange:NSMakeRange(0, 4)];
    NSString *str2=[self substringWithRange:NSMakeRange(5, 2)];
    NSString *str3=[self substringWithRange:NSMakeRange(8, 2)];
    return [NSString stringWithFormat:@"%@.%d.%d",str1,[str2 intValue],[str3 intValue]];
}


-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

//求有行间距的label高度
- (CGSize)boundingRectWithSize:(CGSize)size WithStr:(NSString*)string andFont:(UIFont *)font andLinespace:(CGFloat)space
{
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:space];
    NSDictionary *attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
    CGSize retSize = [string boundingRectWithSize:size
                                          options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    
    return retSize;
}

// 获取这个字符串ASting中的所有abc的所在的index
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText {
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:3];
    if (findText == nil || [findText isEqualToString:@""]) return nil;
    
    NSRange rang = [text rangeOfString:findText]; //获取第一次出现的range
    if (rang.location != NSNotFound && rang.length != 0) {
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];//将第一次的加入到数组中
        NSRange rang1 = {0,0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int i = 0;; i++) {
            if (0 == i) {
               //去掉这个abc字符串
                location = rang.location + rang.length;
                length = text.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            } else {
                location = rang1.location + rang1.length;
                length = text.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            //在一个range范围内查找另一个字符串的range
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            if (rang1.location == NSNotFound && rang1.length == 0) {
                break;
            } else//添加符合条件的location进数组
            [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
        }
        return arrayRanges;
    }
    return nil;
}

+ (NSString *)moneyThousandsFormat:(NSString *)moneyTxt  isHasDecimal:(BOOL)isHasDecimal{
    
    if (isHasDecimal) { //保留小数后两位
       
        if(!moneyTxt || [moneyTxt floatValue] == 0){
            return @"0.00";
        }else{
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setPositiveFormat:@",###.00;"];
            return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[moneyTxt doubleValue]]];
        }
        return @"";
        
    }else{ //不保留小数后两位
        
        if(!moneyTxt || [moneyTxt floatValue] == 0){
            return @"0";
        }else{
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setPositiveFormat:@",###;"];
            return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[moneyTxt doubleValue]]];
        }
        return @"";
    }
}

+(NSArray*)getStringTokenizerWithStr:(NSString*)string
{
    NSMutableArray *keywords = [[NSMutableArray alloc] init];
    CFStringTokenizerRef ref = CFStringTokenizerCreate(NULL,  (__bridge CFStringRef)string, CFRangeMake(0, string.length), kCFStringTokenizerUnitWord, NULL);// 创建分词器
    CFRange range;// 当前分词的位置
    // 获取第一个分词的范围
    CFStringTokenizerAdvanceToNextToken(ref);
    range = CFStringTokenizerGetCurrentTokenRange(ref);
    
    // 循环遍历获取所有分词并记录到数组中
    NSString *keyWord;
    while (range.length>0) {
        keyWord = [string substringWithRange:NSMakeRange(range.location, range.length)];
        [keywords addObject:keyWord];
        CFStringTokenizerAdvanceToNextToken(ref);
        range = CFStringTokenizerGetCurrentTokenRange(ref);
    }
    
    return keywords;
}

//变速箱类型  ---  1：手动  2：自动
+ (NSString *)convertGearboxToText:(NSString *)string
{
    if ([string isEqualToString:@"1"]) {
        return @"手动";
    }else if ([string isEqualToString:@"2"]){
        return @"自动";
    }else if ([string isEqualToString:@"0"]){
        return @"";
    }else{
        return nil;
    }
}
+ (NSString *)convertGearboxToDigit:(NSString *)string
{
    if ([string isEqualToString:@"手动"]) {
        return @"1";
    }else if ([string isEqualToString:@"自动"]){
        return @"2";
    }else if ([string isEqualToString:@""]){
        return @"0";
    }else{
        return nil;
    }
}

//车门数 --- 1、2、3 分别代表 两门、四门、六门
+ (NSString *)convertDoorNumToText:(NSString *)string
{
    if ([string isEqualToString:@"1"]) {
        return @"两门";
    }else if ([string isEqualToString:@"2"]){
        return @"四门";
    }else if ([string isEqualToString:@"3"]){
        return @"六门";
    }else if ([string isEqualToString:@"0"]){
        return @"";
    }else{
        return nil;
    }
}
+ (NSString *)convertDoorNumToDigit:(NSString *)string
{
    if ([string isEqualToString:@"两门"]) {
        return @"1";
    }else if ([string isEqualToString:@"四门"]){
        return @"2";
    }else if ([string isEqualToString:@"六门"]){
        return @"3";
    }else if ([string isEqualToString:@""]){
        return @"0";
    }else{
        return nil;
    }
}


//座位数 --- 2-7、8为7座以上
+ (NSString *)convertSeatNumToText:(NSString *)string
{
    if ([string isEqualToString:@"2"]) {
        return @"2座";
    }else if ([string isEqualToString:@"4"]){
        return @"4座";
    }else if ([string isEqualToString:@"5"]){
        return @"5座";
    }else if ([string isEqualToString:@"6"]){
        return @"6座";
    }else if ([string isEqualToString:@"7"]){
        return @"7座";
    }else if ([string isEqualToString:@"8"]){
        return @"7座以上";
    }else if ([string isEqualToString:@"0"]){
        return @"";
    }
    else{
        return nil;
    }
}

+ (NSString *)convertSeatNumToDigit:(NSString *)string
{
    if ([string isEqualToString:@"2座"]) {
        return @"2";
    }else if ([string isEqualToString:@"4座"]){
        return @"4";
    }else if ([string isEqualToString:@"5座"]){
        return @"5";
    }else if ([string isEqualToString:@"6座"]){
        return @"6";
    }else if ([string isEqualToString:@"7座"]){
        return @"7";
    }else if ([string isEqualToString:@"7座以上"]){
        return @"8";
    }else if ([string isEqualToString:@""]){
        return @"0";
    }
    else{
        return nil;
    }
}


//真皮座椅  ---  1：有  3：无
+ (NSString *)convertSeatTypeToText:(NSString *)string
{
    if ([string isEqualToString:@"1"]) {
        return @"有";
    }else if ([string isEqualToString:@"3"]){
        return @"无";
    }else if ([string isEqualToString:@"0"]){
        return @"";
    }
    else{
        return nil;
    }
}
+ (NSString *)convertSeatTypeToDigit:(NSString *)string
{
    if ([string isEqualToString:@"有"]) {
        return @"1";
    }else if ([string isEqualToString:@"无"]){
        return @"3";
    }else if ([string isEqualToString:@""]){
        return @"0";
    }
    else{
        return nil;
    }
}

//天窗配置  ---  1：无  2：有  3：全景  4：敞篷
+ (NSString *)convertSkylightsTypeToText:(NSString *)string
{
    if ([string isEqualToString:@"1"]) {
        return @"无";
    }else if ([string isEqualToString:@"2"]){
        return @"有";
    }else if ([string isEqualToString:@"3"]){
        return @"全景";
    }else if ([string isEqualToString:@"4"]){
        return @"敞篷";
    }else if ([string isEqualToString:@"0"]){
        return @"";
    }else{
        return nil;
    }
}
+ (NSString *)convertSkylightsTypeToDigit:(NSString *)string
{
    if ([string isEqualToString:@"无"]) {
        return @"1";
    }else if ([string isEqualToString:@"有"]){
        return @"2";
    }else if ([string isEqualToString:@"全景"]){
        return @"3";
    }else if ([string isEqualToString:@"敞篷"]){
        return @"4";
    }else if ([string isEqualToString:@""]){
        return @"0";
    }else{
        return nil;
    }

}


//倒车辅助  ---  1：无  2：倒车雷达  3：倒车影像
+ (NSString *)convertRadarToText:(NSString *)string
{
    if ([string isEqualToString:@"1"]) {
        return @"无";
    }else if ([string isEqualToString:@"2"]){
        return @"倒车雷达";
    }else if ([string isEqualToString:@"3"]){
        return @"倒车影像";
    }else if ([string isEqualToString:@"0"]){
        return @"";
    }else{
        return nil;
    }
}
+ (NSString *)convertRadarToDigit:(NSString *)string
{
    if ([string isEqualToString:@"无"]) {
        return @"1";
    }else if ([string isEqualToString:@"倒车雷达"]){
        return @"2";
    }else if ([string isEqualToString:@"倒车影像"]){
        return @"3";
    }else if ([string isEqualToString:@""]){
        return @"0";
    }else{
        return nil;
    }
}


//驱动方式  ---  1：两驱  2：四驱
+ (NSString *)convertDriveTypeToText:(NSString *)string
{
    if ([string isEqualToString:@"1"]) {
        return @"两驱";
    }else if ([string isEqualToString:@"2"]){
        return @"四驱";
    }else if ([string isEqualToString:@"0"]){
        return @"";
    }else{
        return nil;
    }
}
+ (NSString *)convertDriveTypeToDigit:(NSString *)string
{
    if ([string isEqualToString:@"两驱"]) {
        return @"1";
    }else if ([string isEqualToString:@"四驱"]){
        return @"2";
    }else if ([string isEqualToString:@""]){
        return @"0";
    }else{
        return nil;
    }
}
@end
