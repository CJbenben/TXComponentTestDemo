//
//  UIImage+ImgSize.m
//  ShopMobile
//
//  Created by greenleaf on 2019/1/22.
//  Copyright © 2019 soubao. All rights reserved.
//

#import "UIImage+ImgSize.h"
#import <ImageIO/ImageIO.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import <SDWebImage/SDImageCache.h>
@implementation UIImage (ImgSize)
/**
 *  根据图片url获取网络图片尺寸
 */
+ (CGSize)getImageSizeWithURLStr:(id)URLStr {
    NSString *urlStr = @"";
    if ([URLStr isKindOfClass:[NSURL class]]) {
        NSURL *url = (NSURL *)URLStr;
        urlStr = url.absoluteString;
    }
    if ([URLStr isKindOfClass:[NSString class]]) {
        urlStr = URLStr;
    }
    if (urlStr.length == 0) {
        return CGSizeZero;
    }
    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:urlStr];
    return image.size;
}

 /**
  @brief 根据图片 ur l获取网络图片尺寸（建议使用，200416_对获取的图片尺寸做缓存处理了）
  @param URL                             网络图片地址，可为 NSURL or NSString 类型
  @return                网络图尺寸大小（不可直接赋值给 imageView.size）
 */
 + (CGSize)getImageSizeWithURL:(id)URL {
    NSURL *imgURL = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        imgURL = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        imgURL = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    NSString *cacheImgSizeStr = [[NSUserDefaults standardUserDefaults] objectForKey:imgURL.absoluteString];
    if (cacheImgSizeStr.length) {
        return CGSizeFromString(cacheImgSizeStr);
    } else {
        //将最终的自适应的高度 本地化处理
        CGSize imageSize = [UIImage getInternetImageSizeWithURL:URL];
        [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGSize(imageSize) forKey:imgURL.absoluteString];
        return imageSize;
    }
}

/**
 @brief 根据图片 url 获取网络图片尺寸 后 返回 imageView 需要的图片大小（建议使用，200416_对获取的图片尺寸做缓存处理了）
 @param URL                             网络图片地址，可为 NSURL or NSString 类型
 @param imageWidth              屏幕中需要显示 imageView 的宽度
 @return                网络图尺寸大小（可直接赋值给 imageView.size）
*/
+ (CGSize)getImageSizeWithURL:(id)URL imageWidth:(CGFloat)imageWidth {
    CGSize interImgSize = [self getImageSizeWithURL:URL];
    if (interImgSize.width == 0) {
        return CGSizeZero;
    } else {
        // 高宽比
        CGFloat hwScale = interImgSize.height/interImgSize.width;
        return CGSizeMake(imageWidth, hwScale * imageWidth);
    }
}

// 优化之前卡顿的方法
+ (CGSize)getInternetImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
    //NSLog(@"w = %f,h = %f",image.size.width,image.size.height);
    return image.size;
}

// 此方法有点卡顿
+ (CGSize)getInternetImageSizeWithURL2:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    
    if (imageSourceRef) {
        
        // 获取图像属性
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        
        //以下是对手机32位、64位的处理
        if (imageProperties != NULL) {
            
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            /***************** 此处解决返回图片宽高相反问题 *****************/
            // 图像旋转的方向属性
            NSInteger orientation = [(__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyOrientation) integerValue];
            CGFloat temp = 0;
            switch (orientation) {  // 如果图像的方向不是正的，则宽高互换
                case UIImageOrientationLeft: // 向左逆时针旋转90度
                case UIImageOrientationRight: // 向右顺时针旋转90度
                case UIImageOrientationLeftMirrored: // 在水平翻转之后向左逆时针旋转90度
                case UIImageOrientationRightMirrored: { // 在水平翻转之后向右顺时针旋转90度
                    temp = width;
                    width = height;
                    height = temp;
                }
                    break;
                default:
                    break;
            }
            /***************** 此处解决返回图片宽高相反问题 *****************/
            
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}


/**
 @brief  获取视频第一帧图（做了缓存处理）
 @param path          网络视频地址， NSURL  类型
 */
+ (UIImage*)getVideoFirstViewImage:(NSURL *)path {
    
    NSData *cacheImageData = [[NSUserDefaults standardUserDefaults] objectForKey:path.absoluteString];
    if (cacheImageData) {
        return  [UIImage imageWithData:cacheImageData];
    } else {
        UIImage *videoFirstImg = [self getFirstImgFromVideoUrlPath:path];
        NSData *videoFirstData = UIImagePNGRepresentation(videoFirstImg);
        [[NSUserDefaults standardUserDefaults] setObject:videoFirstData forKey:path.absoluteString];
        return videoFirstImg;
    }
}

+ (UIImage *)getFirstImgFromVideoUrlPath:(NSURL *)path {
//    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
//    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
//
//    assetGen.appliesPreferredTrackTransform = YES;
//    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
//    NSError *error = nil;
//    CMTime actualTime;
//    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
//    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
//    CGImageRelease(image);
//    return videoImage;
    return nil;
}

+ (UIImage *)base64StrToUIImage:(NSString *)encodedImageStr {
    NSData *strData = [NSData dataWithContentsOfURL:[NSURL URLWithString:encodedImageStr]];
    UIImage *decodedImage = [UIImage imageWithData:strData];
    return decodedImage;
}


+ (UIImage *)imageAddLocalImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage addFrame:(CGRect)frame
{
    
    UIGraphicsBeginImageContextWithOptions(useImage.size ,NO, 0.0);
    [useImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height)];
    
    //四个参数为水印图片的位置
    [maskImage drawInRect:frame];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)screenshotGetImageWithCurrView:(UIView *)currView {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(currView.frame.size.width, currView.frame.size.height), NO, 0.0);//currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    [currView.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
    return viewImage;
    
}

- (UIImage *)imageWithRoundedCornersAndSize:(CGSize)sizeToFit  {
    CGRect rect = (CGRect){0.f, 0.f, sizeToFit};
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:sizeToFit.width].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
}

//func kt_drawRectWithRoundedCorner(radius radius: CGFloat,
//                       borderWidth: CGFloat,
//                                  backgroundColor: UIColor,
//                                  borderColor: UIColor) -> UIImage {
//     UIGraphicsBeginImageContextWithOptions(sizeToFit, false, UIScreen.mainScreen().scale)
//     let context = UIGraphicsGetCurrentContext()
//
//     CGContextMoveToPoint(context, 开始位置);  // 开始坐标右边开始
//     CGContextAddArcToPoint(context, x1, y1, x2, y2, radius);  // 这种类型的代码重复四次
//
//     CGContextDrawPath(UIGraphicsGetCurrentContext(), .FillStroke)
//     let output = UIGraphicsGetImageFromCurrentImageContext();
//     UIGraphicsEndImageContext();
//     return output
//}

/**
@brief  UIColor 转 UIImage
@param color                UIColor
@return            image
*/
+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
