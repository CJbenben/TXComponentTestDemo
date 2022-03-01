//
//  PlayerCustomView.h
//  Demo
//
//  Created by chenxiaojie on 2019/11/22.
//  Copyright © 2019 ChenJie. All rights reserved.
//

#import "DadView.h"
#import "NSTimer+Add.h"

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


/**
 *  为记录不同 page 埋点区分
 */
typedef NS_ENUM(NSUInteger, CycleScrollFromPage) {
    CycleScrollFromPageRenterHome = 0,
    CycleScrollFromPageOwnerHome,
};

NS_ASSUME_NONNULL_BEGIN

@interface PlayerCustomView : DadView


/**
 * 当点击的时候，执行的block
 */
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

/**
 * 滚动停止的时候，执行的block
 */
@property (nonatomic , copy) void (^ScrollActionBlock)(NSInteger pageIndex);

/**
 *  小数点位置
 */
@property (assign, nonatomic) PageControlPostion pageControllPostion;


/**
 * 不需要记录埋点不需要设置
 */
@property (nonatomic, assign) CycleScrollFromPage fromPage;

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

NS_ASSUME_NONNULL_END
