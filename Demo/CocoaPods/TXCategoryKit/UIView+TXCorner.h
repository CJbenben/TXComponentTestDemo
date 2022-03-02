//
//  UIView+TXCorner.h
//  SXYOA
//
//  Created by MAC_MINI on 17/1/15.
//  Copyright © 2017年 zhongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TXShadowPathType){
    TXShadowPathTop,        // 只有上面阴影
    TXShadowPathBottom,     // 只有下面阴影
    TXShadowPathLeft,       // 只有左边阴影
    TXShadowPathRight,      // 只有右边阴影
    TXShadowPathCommon,     // 四边都有阴影
    TXShadowPathAround      // 只有左右下面有阴影
};

@interface UIView (TXCorner)
+ (void)drawRectContentViewCorner:(UIView *)cellContentView bounds:(CGRect)bounds cornerStyle:(UIRectCorner)style cornerRadius:(CGSize)size;
+ (void)drawRectContentViewCorner:(UIView *)cellContentView cornerStyle:(UIRectCorner)style cornerRadius:(CGSize)size;
+ (void)drawRectContentViewCorner:(UIView *)cellContentView cornerStyle:(UIRectCorner)style;

+ (void)drawRectContentViewBottomCorner:(UIView *)contentView dataArray:(NSArray *)array indexPath:(NSIndexPath *)indexPath;

+ (void)drawRectContentView:(UIView *)cellContentView dataArray:(NSArray *)array indexPath:(NSIndexPath *)indexPath;
/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;

/**
 @brief UIView添加阴影效果 四周或者单边阴影
 @param shadowColor         阴影颜色
 @param shadowOpacity        阴影透明度，默认0
 @param shadowRadius      阴影半径，默认0
 @param shadowPathType        阴影方向
 @param shadowPathWidth     空白页刷新文案
 */
- (void)viewShadowPathWithColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowPathType:(TXShadowPathType)shadowPathType shadowPathWidth:(CGFloat)shadowPathWidth;
@end
