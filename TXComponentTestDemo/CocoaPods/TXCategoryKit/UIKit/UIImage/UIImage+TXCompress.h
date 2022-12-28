//
//  UIImage+TXCompress.h
//  TXCategoryKitDemo
//
//  Created by chenxiaojie on 2022/11/17.
//  Copyright © 2022 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 图片压缩 */
@interface UIImage (TXCompress)

/**
 @brief 压缩一张图片 最大宽高1280 类似于微信算法
 @image 原图
 @return 压缩后 image
 */
+ (UIImage *)getJPEGImagerImg:(UIImage *)image;

/**
 @brief 压缩一张图片指定文件大小，不超过不压缩
 @image 原图
 @maxFileSize 最大文件大小 10 * 1024 * 1024 = 10M
 @return 压缩后 NSData
 */
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;

+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
