//
//  UIColor+CJColor.h
//  Autoyol
//
//  Created by chenxiaojie on 15/5/13.
//  Copyright (c) 2015年 Autoyol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CJColor)

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

@end
