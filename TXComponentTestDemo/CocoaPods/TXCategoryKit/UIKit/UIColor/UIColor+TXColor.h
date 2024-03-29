//
//  UIColor+TXColor.h
//  Autoyol
//
//  Created by chenxiaojie on 15/5/13.
//  Copyright (c) 2015年 Autoyol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TXColor)

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexColorStr;
+ (UIColor *)colorWithHexString:(NSString *)hexColorStr grayColor:(BOOL)grayColor;
+ (UIColor *)colorWithHexString:(NSString *)hexColorStr grayColor:(BOOL)grayColor alpha:(CGFloat)alpha;

@end
