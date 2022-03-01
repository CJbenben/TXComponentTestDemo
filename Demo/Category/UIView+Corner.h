//
//  UIView+Corner.h
//  SXYOA
//
//  Created by MAC_MINI on 17/1/15.
//  Copyright © 2017年 zhongyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Corner)
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
@end
