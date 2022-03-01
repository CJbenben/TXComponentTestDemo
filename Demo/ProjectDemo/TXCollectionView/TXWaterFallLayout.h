//
//  TXWaterFallLayout.h
//  Demo
//
//  Created by chenxiaojie on 2020/3/1.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TXWaterFallLayout;

NS_ASSUME_NONNULL_BEGIN

@protocol TXWaterFallLayoutDelegate <NSObject>

// item 高度
- (CGFloat)waterFallLayout:(TXWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth;

@optional
// 多少列
- (NSUInteger)numberColumnsInWaterFallLayout:(TXWaterFallLayout *)waterFallLayout;
// 列间距
- (CGFloat)columnSpacingInWaterFallLayout:(TXWaterFallLayout *)waterFallLayout;
// 行间距
- (CGFloat)lineSpacingInWaterFallLayout:(TXWaterFallLayout *)waterFallLayout;
// 边距
- (UIEdgeInsets)sectionInsetInWaterFallLayout:(TXWaterFallLayout *)waterFallLayout;
@end

@interface TXWaterFallLayout : UICollectionViewLayout

@property (nonatomic, weak) id<TXWaterFallLayoutDelegate> delegate;

// 总列数
@property (nonatomic, assign) NSInteger columnCount;
// 列间距
@property (nonatomic, assign) CGFloat columnSpacing;
// 行间距
@property (nonatomic, assign) CGFloat lineSpacing;
// 边距
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@end

NS_ASSUME_NONNULL_END
