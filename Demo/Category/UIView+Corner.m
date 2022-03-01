//
//  UIView+Corner.m
//  SXYOA
//
//  Created by MAC_MINI on 17/1/15.
//  Copyright © 2017年 zhongyang. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)
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
@end
