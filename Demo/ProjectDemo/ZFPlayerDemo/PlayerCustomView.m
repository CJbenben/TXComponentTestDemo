//
//  PlayerCustomView.m
//  Demo
//
//  Created by chenxiaojie on 2019/11/22.
//  Copyright © 2019 ChenJie. All rights reserved.
//

#import "PlayerCustomView.h"
#import "UIImageView+WebCache.h"

/**
 *  系统 pageControl 大小
 */
#define PAGECONTROL_WIDTH       20
#define PAGECONTROL_HEIGHT      20

/**
 *  自定义 pageControl 背景宽高
 */
#define BGPAGECONTROLVIEWWIDTH  200
#define BGPAGECONTROLVIEWHEIGHT 1.5
/**
 *  自定义 progressview 单个宽
 */
#define PROGRESSSINGLEWIDTH     20

/**
 *  自定义 pageControl 背景颜色
 */
#define BGPROGRESSCOLOR         [UIColor whiteColor]
#define PROGRESSCOLOR           [UIColor whiteColor]

@interface PlayerCustomView ()

@property (nonatomic, assign) CGRect scrollViewF;
@property (nonatomic, assign) CGRect imageViewF;

/**
 *  滚动图片总数
 */
@property (assign, nonatomic) NSInteger imageCount;

/**
 *  当前页
 */
@property (assign, nonatomic) CGFloat currentIndex;

@property (assign, nonatomic) CGFloat x;

/**
 *  动画时间
 */
@property (nonatomic , assign) NSTimeInterval animationDuration;

/**
 *  滚动视图异常处理计数
 */
@property (assign, nonatomic) NSInteger scrollAbnormalCount;

/**
 *  pageControl背景view
 */
@property (nonatomic, strong) UIView *bgPageControlView;
@property (nonatomic, assign) CGFloat bgPageControlViewW;

/**
 *  pageControl 实时滚动 progressview
 */
@property (nonatomic, strong) UIView *progressView;

@property (nonatomic, assign) CGFloat progressIndex;

@property (assign, nonatomic) CGFloat imageX;

@end
@implementation PlayerCustomView

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _scrollView.backgroundColor = [UIColor systemRedColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 200);
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
    }
    return self;
}

+ (instancetype)atzucheCycleScrollViewFrame:(CGRect)scrollViewF imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius imagePaths:(NSArray *)imagePaths animationDuration:(NSTimeInterval)animationDuration {
    return [[self alloc] initWithFrame:scrollViewF imageViewFrame:imageViewF radius:radius imagePaths:imagePaths animationDuration:animationDuration];
}

- (instancetype)initWithFrame:(CGRect)frame imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius imagePaths:(NSArray *)imagePaths animationDuration:(NSTimeInterval)animationDuration {
    if (self = [super initWithFrame:frame]) {
        if (imagePaths.count == 0) {
            return self;
        }
        self.scrollViewF = frame;
        self.imageViewF = imageViewF;
        self.x = SCREEN_WIDTH;
        if (animationDuration > 0.0 && imagePaths.count != 1) {// 只有一张图片不需要滚动
            self.timer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration) target:self selector:@selector(updateCycleScrollImagesLocation) userInfo:nil repeats:YES];
        }
        CGRect scrollFrame = CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height);
        
        CGRect imageViewFrame = imageViewF;
        self.imageX = imageViewFrame.origin.x;
        
        // 修改数据源、完成循环轮播
        NSMutableArray *imageAry = [imagePaths mutableCopy];
        NSString *firstObj = [imageAry firstObject];
        NSString *lastObj = [imageAry lastObject];
        [imageAry insertObject:lastObj atIndex:0];
        [imageAry insertObject:firstObj atIndex:imageAry.count];
        
        self.scrollView = [self createScrollViewWithPath:imageAry scrollViewFrame:scrollFrame imageViewFrame:imageViewFrame radius:radius];
        if (imagePaths.count == 1) {
            self.scrollView.scrollEnabled = NO;
        }
        self.scrollView.delegate = self;
        CGRect frame = scrollFrame;
        frame.origin.x = frame.size.width;
        [self addSubview:self.scrollView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [self.scrollView addGestureRecognizer:tapGesture];
        
        [imageAry removeObjectAtIndex:0];
        [imageAry removeObjectAtIndex:imageAry.count - 1];
        self.imageCount = imageAry.count;
        
        /*
        CGRect pageFrame = CGRectMake(frame.size.width/2.0 - 15, frame.size.height - 30, 30, 30);
        self.pageControl = [self createPageControl:imageAry frame:pageFrame];
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.pageControl];
        */
        [self addSubview:self.bgPageControlView];
        [self.bgPageControlView addSubview:self.progressView];
        
        [self.scrollView scrollRectToVisible:frame animated:NO];
    }
    return self;
}

#pragma mark - Action
- (void)updateCycleScrollImagesLocation{
    
    self.x +=  SCREEN_WIDTH;
    
    int count = (int)self.x % (int)SCREEN_WIDTH;
    
    self.scrollAbnormalCount = self.x/SCREEN_WIDTH;
    
    if (count == 0) {
        [self.scrollView setContentOffset:CGPointMake(self.x, 0) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * (self.scrollAbnormalCount + 1), 0) animated:YES];
    }
    
    if (self.x == SCREEN_WIDTH * (self.imageCount + 1)) {
        self.x = SCREEN_WIDTH;
    }
}

- (void)changePage:(UIPageControl *)pageControl{
    NSLog(@"小按钮点点点");
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)gr{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentIndex);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    self.progressIndex = self.currentIndex - 1;
    
    //NSLog(@"self.currentIndex:%.2f",self.currentIndex);
    
    CGRect frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, scrollView.frame.size.height);
    
    if (scrollView == self.scrollView) {
        
        if ((NSInteger)self.currentIndex == self.currentIndex) {//判断整数
            self.pageControl.currentPage = self.currentIndex - 1;
            if (self.currentIndex - 1 == self.imageCount) {
                frame.origin.x = SCREEN_WIDTH;
                self.x = frame.origin.x;
                [self.scrollView scrollRectToVisible:frame animated:NO];
            }else if (self.currentIndex == 0){
                frame.origin.x = SCREEN_WIDTH * self.imageCount;
                self.x = frame.origin.x;
                [self.scrollView scrollRectToVisible:frame animated:NO];
            }else{
                self.x = self.currentIndex * SCREEN_WIDTH;
            }
            
        }
    }else if (scrollView == self.scrollView){//预留
        self.pageControl.currentPage = self.currentIndex - 1;
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.timer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    
    if (currIndex == self.imageCount + 1) {
        currIndex = 1;
    } else if (currIndex == 0) {
        currIndex = self.imageCount;
    }
    if (self.ScrollActionBlock) {
        self.ScrollActionBlock(currIndex);
    }
    
    //NSLog(@"scroview.x = %.2f  currIndex = %d", scrollView.contentOffset.x, currIndex);
    
//    if (self.fromPage == CycleScrollFromPageRenterHome) {
//        [AtzucheMobStat writeContentWith:@"19" EventId:@"210" Content:[NSString stringWithFormat:@"pic_position=%.0f", currIndex]];
//    } else if (self.fromPage == CycleScrollFromPageOwnerHome) {
//        NSString *imageUrlPath = safeObjectTxAtIndex(self.imagePathsAry, currIndex - 1);
//        [AtzucheMobStat writeContentWith:@"29" EventId:@"427" Content:[NSString stringWithFormat:@"url=%@;position=%.0f",imageUrlPath, currIndex - 1]];
//    }

}

- (UIScrollView *)createScrollViewWithPath:(NSMutableArray *)imagesPathAry scrollViewFrame:(CGRect)scrollViewF imageViewFrame:(CGRect)imageViewF radius:(CGFloat)radius{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewF];
    scrollView.contentSize = CGSizeMake(scrollViewF.size.width * imagesPathAry.count, scrollViewF.size.height);
    for (int i = 0; i<imagesPathAry.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imagesPathAry[i]] placeholderImage:[UIImage imageNamed:@"pageLoading.jpg"] options:SDWebImageRefreshCached];
        
        if (radius != 0) {
            imageView.layer.borderColor = [UIColor clearColor].CGColor;
            imageView.layer.borderWidth = 1.0;
            imageView.layer.cornerRadius = radius;
            imageView.layer.masksToBounds = YES;
        }
        
        imageViewF.origin = CGPointMake(scrollView.frame.size.width * i + self.imageX, 0);
        imageViewF.size = imageViewF.size;
        imageView.frame = imageViewF;
        [scrollView addSubview:imageView];
    }
    scrollView.pagingEnabled = YES;//设置整屏滚动
    scrollView.bounces = NO;//设置边缘无弹跳
    scrollView.showsHorizontalScrollIndicator = NO;//水平滚动条
    scrollView.showsVerticalScrollIndicator = NO;//竖直滚动条
    return scrollView;
}

- (UIPageControl *)createPageControl:(NSArray *)images frame:(CGRect)frame{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.frame = frame;
    pageControl.numberOfPages = images.count;
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.userInteractionEnabled = YES;
    return pageControl;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
