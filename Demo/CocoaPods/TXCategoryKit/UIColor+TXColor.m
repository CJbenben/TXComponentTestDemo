//
//  UIColor+TXColor.h
//  Autoyol
//
//  Created by chenxiaojie on 15/5/13.
//  Copyright (c) 2015年 Autoyol. All rights reserved.
//

#import "UIColor+TXColor.h"

@implementation UIColor (TXColor)

+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexColorStr
{
    NSString * cString = [[hexColorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor clearColor];
    
    if (cString.length == 7 && [cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if (cString.length == 8 && [cString containsString:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    NSScanner *scanner = [NSScanner scannerWithString:cString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum alpha:1.0];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
    return [self colorWithRGBHex:hex alpha:1.0];
}

@end
