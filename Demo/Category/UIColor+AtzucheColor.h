//
//  UIColor+AtzucheColor.h
//  Autoyol
//
//  Created by Ning Gang on 15/5/13.
//  Copyright (c) 2015年 Autoyol. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#undef  RGBACOLOR
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#undef	HEX_RGB
#define HEX_RGB(V)		[UIColor colorWithRGBHex:V]

#define CG_RGBCOLOR(r,g,b) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0].CGColor

#define CG_RGBACOLOR(r,g,b,a) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:a].CGColor

// 随机色
#define RandomColor RGBCOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define ClearColor  [UIColor clearColor]

@interface UIColor (AtzucheColor)

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)colorWithCssName:(NSString *)cssColorName;

+ (UIColor *)bgColor_nav;
+ (UIColor *)bgColor_view;
+ (UIColor *)bgColor_cell;

+ (UIColor *)textColor_dark;
+ (UIColor *)textColor_light;

//add by fanxiao
+ (UIColor *) colorWithHex:(uint) hex alpha:(CGFloat)alpha;


@end
