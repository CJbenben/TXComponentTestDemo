//
//  TXCycleScrollView.h
//  Demo
//
//  Created by ChenJie on 2018/1/26.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  pageControl位置
 */
typedef NS_ENUM(NSUInteger, PageControlPostion) {
    /** Center position. */
    PageControlPostionCenter = 0,
    /** top position. */
    PageControlPostionTop,
    /** left position. */
    PageControlPostionLeft,
    /** bottom position. */
    PageControlPostionBottom,
    /** right position. */
    PageControlPostionRight,
    /** null position. */
    PageControlPostionNull,
};

@interface TXCycleScrollView : UIView

/**
 * 当点击的时候，执行的block
 */
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

/**
 *  小数点位置
 */
@property (assign, nonatomic) PageControlPostion pageControllPostion;

/**
 *  定时器
 */
@property(nonatomic,strong) NSTimer *timer;

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) UIPageControl *pageControl;

+ (instancetype)atzucheCycleScrollViewFrame:(CGRect)scrollViewF imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius imagePaths:(NSArray *)imagePaths animationDuration:(NSTimeInterval)animationDuration;

/**
 *  加载网络图片、缓存处理(bannar图片自定义frame)
 *
 *  @param frame             scrollViewFrame
 *  @param imageViewF        一张图片的frame
 *  @param radius            圆角大小
 *  @param imagePaths        动态图片地址数组(可变)
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动
 *
 *  @return nil
 */
- (instancetype)initWithFrame:(CGRect)frame imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius imagePaths:(NSArray *)imagePaths animationDuration:(NSTimeInterval)animationDuration;

@end
