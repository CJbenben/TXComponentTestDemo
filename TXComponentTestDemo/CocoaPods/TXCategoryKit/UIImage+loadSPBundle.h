//
//  UIImage+loadSPBundle.h
//  SPComponentDev
//
//  Created by yue on 2018/11/14.
//  Copyright © 2018年 chenxiaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientType_topToBottom = 0,       //从上到下
    GradientType_leftToRight,           //从左到右
    GradientType_upleftTolowRight,      //左上到右下
    GradientType_uprightTolowLeft,      //右上到左下
};


@interface UIImage (loadSPBundle)

+ (instancetype)loadSPImageWithName:(NSString *)name bundle:(NSString *)bundleName targetClass:(Class)targetClass;

/**
 @brief 返回一个渐变色的图片(建议颜色设置为2个相近色为佳，设置3个相近色能形成拟物化的凸起感)
 @param colors       颜色数组
 @param frame        要设置的frame大小
 @param gradientType 渐变方向
 @return UIIamge
 */
+ (UIImage*)imageFromColors:(NSArray*)colors frame:(CGRect)frame  byGradientType:(GradientType)gradientType;

/**
 @brief 字符串转图片二维码
 @param qrcodeStr    需要转二维码的字符串
 @return UIIamge
 */
+ (UIImage *)loadQRCodeImgWithStr:(NSString *)qrcodeStr;

/**
 @brief 截图功能
 @param view        当前view
 @return 截图后 image
 */
+ (UIImage *)captureImageFromView:(UIView *)view;

/**
 @brief 截图功能
 @param view        当前view
 @param imageRect   截取指定尺寸的图片
 @return 截图后 image
 */
+ (UIImage *)captureImageFromView:(UIView *)view imageRect:(CGRect)imageRect;

/**
 @brief UIColor 转 UIImage
 @param color        UIColor
 @return  UIimage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
