//
//  UIImage+ImgSize.h
//  ShopMobile
//
//  Created by greenleaf on 2019/1/22.
//  Copyright © 2019 soubao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ImgSize)

/**
 @brief 根据图片 ur l获取网络图片尺寸（建议使用，200416_对获取的图片尺寸做缓存处理了）
 @param URL                             网络图片地址，可为 NSURL or NSString 类型
 @return                网络图尺寸大小（不可直接赋值给 imageView.size）
*/
+ (CGSize)getImageSizeWithURL:(id)URL;

/**
 @brief 根据图片 url 获取网络图片尺寸 后 返回 imageView 需要的图片大小（建议使用，200416_对获取的图片尺寸做缓存处理了）
 @param URL                             网络图片地址，可为 NSURL or NSString 类型
 @param imageWidth              屏幕中需要显示 imageView 的宽度
 @return                网络图尺寸大小（可直接赋值给 imageView.size）
*/
+ (CGSize)getImageSizeWithURL:(id)URL imageWidth:(CGFloat)imageWidth;

/**
 @brief  根据图片url获取网络图片尺寸（缺点：需要 sd 先加载此图片后才可以获取到）
 @param URLStr          网络图片地址，可为 NSURL or NSString 类型
 */
+ (CGSize)getImageSizeWithURLStr:(id)URLStr;

/**
@brief  获取视频第一帧图片
@param path          网络视频地址， NSURL  类型
*/
+ (UIImage*)getVideoFirstViewImage:(NSURL *)path;

+ (UIImage *)base64StrToUIImage:(NSString *)encodedImageStr;

+ (UIImage *)imageAddLocalImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage addFrame:(CGRect)frame;

/**
 @brief  根据 传入 view 截屏
 @param currView         需要截屏的当前 view
 @return            image
 */
+ (UIImage *)screenshotGetImageWithCurrView:(UIView *)currView;

- (UIImage *)imageWithRoundedCornersAndSize:(CGSize)sizeToFit;

/**
@brief  UIColor 转 UIImage
@param color                UIColor
@return            image
*/
+ (UIImage *)createImageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
