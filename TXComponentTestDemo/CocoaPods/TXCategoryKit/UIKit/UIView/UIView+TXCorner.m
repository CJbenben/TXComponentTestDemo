//
//  UIView+TXCorner.m
//  SXYOA
//
//  Created by MAC_MINI on 17/1/15.
//  Copyright © 2017年 zhongyang. All rights reserved.
//

#import "UIView+TXCorner.h"

@implementation UIView (TXCorner)
+ (void)drawRectContentViewCorner:(UIView *)cellContentView bounds:(CGRect)bounds cornerStyle:(UIRectCorner)style cornerRadius:(CGSize)size
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:style cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cellContentView.bounds;
    maskLayer.path = maskPath.CGPath;
    cellContentView.layer.mask = maskLayer;
}
+ (void)drawRectContentViewCorner:(UIView *)cellContentView cornerStyle:(UIRectCorner)style cornerRadius:(CGSize)size
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellContentView.bounds byRoundingCorners:style cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cellContentView.bounds;
    maskLayer.path = maskPath.CGPath;
    cellContentView.layer.mask = maskLayer;
}
+ (void)drawRectContentViewCorner:(UIView *)cellContentView cornerStyle:(UIRectCorner)style {
    [UIView drawRectContentViewCorner:cellContentView cornerStyle:style cornerRadius:CGSizeMake(5, 5)];
}

+ (void)drawRectContentViewBottomCorner:(UIView *)contentView dataArray:(NSArray *)array indexPath:(NSIndexPath *)indexPath {
    if (!array) {
        return;
    }

    if (indexPath.row == (array.count - 1)) {
        [UITableViewCell drawRectContentViewCorner:contentView cornerStyle:UIRectCornerBottomLeft|UIRectCornerBottomRight];
    }
}

+ (void)drawRectContentView:(UIView *)cellContentView dataArray:(NSArray *)array indexPath:(NSIndexPath *)indexPath {
    if (!array) {
        return;
    }

    if (array.count == 1) {
        [UITableViewCell drawRectContentViewCorner:cellContentView cornerStyle:UIRectCornerAllCorners];
        return;
    }

    if (indexPath.row == 0) {
        [UITableViewCell drawRectContentViewCorner:cellContentView cornerStyle:UIRectCornerTopLeft|UIRectCornerTopRight];
    }

    if (indexPath.row == (array.count - 1)) {
        [UITableViewCell drawRectContentViewCorner:cellContentView cornerStyle:UIRectCornerBottomLeft|UIRectCornerBottomRight];
    }
}


+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:lineView.bounds];
    
    if (isHorizonal) {
        
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
        
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

/**
 @brief UIView添加阴影效果 四周或者单边阴影
 @param shadowColor         阴影颜色
 @param shadowOpacity        阴影透明度，默认0
 @param shadowRadius      阴影半径，默认0
 @param shadowPathType        阴影方向
 @param shadowPathWidth     空白页刷新文案
 */
- (void)viewShadowPathWithColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowPathType:(TXShadowPathType)shadowPathType shadowPathWidth:(CGFloat)shadowPathWidth {
    
    self.layer.masksToBounds = NO;//必须要等于NO否则会把阴影切割隐藏掉
    self.layer.shadowColor = shadowColor.CGColor;// 阴影颜色
    self.layer.shadowOpacity = shadowOpacity;// 阴影透明度，默认0
    self.layer.shadowOffset = CGSizeZero;//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowRadius = shadowRadius;//阴影半径，默认3
    CGRect shadowRect = CGRectZero;
    CGFloat originX,originY,sizeWith,sizeHeight;
    originX = 0;
    originY = 0;
    sizeWith = self.bounds.size.width;
    sizeHeight = self.bounds.size.height;
    
    if (shadowPathType == TXShadowPathTop) {
        shadowRect = CGRectMake(originX, originY-shadowPathWidth/2, sizeWith, shadowPathWidth);
    }else if (shadowPathType == TXShadowPathBottom){
        shadowRect = CGRectMake(originY, sizeHeight-shadowPathWidth/2, sizeWith, shadowPathWidth);
    }else if (shadowPathType == TXShadowPathLeft){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY, shadowPathWidth, sizeHeight);
    }else if (shadowPathType == TXShadowPathRight){
        shadowRect = CGRectMake(sizeWith-shadowPathWidth/2, originY, shadowPathWidth, sizeHeight);
    }else if (shadowPathType == TXShadowPathCommon){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, 2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth/2);
    }else if (shadowPathType == TXShadowPathAround){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY-shadowPathWidth/2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth);
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = bezierPath.CGPath;//阴影路径
}

@end
