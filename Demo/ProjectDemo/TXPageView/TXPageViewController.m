//
//  TXPageViewController.m
//  Demo
//
//  Created by chenxiaojie on 2021/1/8.
//  Copyright © 2021 ChenJie. All rights reserved.
//

#import "TXPageViewController.h"

@interface TXPageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation TXPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    
    [CJPrivacyPermissionsTool isContactAuthhorization];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, SCREEN_HEIGHT - naviHeight)];
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    //显示照片的imageView
    _imageView = [[UIImageView alloc]init];
    _imageView.userInteractionEnabled = YES;
    _imageView.size = CGSizeMake(200, 100);
    _imageView.center = self.scrollView.center;
    _imageView.image = [UIImage imageNamed:@"ic_test"];
//    //长按保存手势
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//    [_imageView addGestureRecognizer:longPress];
    [_scrollView addSubview:_imageView];
    //双击缩放手势
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [_imageView addGestureRecognizer:doubleTap];
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
return _imageView;
    
}

- (void)doubleTap:(UITapGestureRecognizer *)recognizer {
    if (_scrollView.zoomScale > 1.0) {
//        [_scrollView setZoomScale:1.0 animated:YES];
        _imageView.transform=CGAffineTransformMakeScale(1,1);//宽高都放大3倍，这个方法是view的transform属性的方法

    } else {
        _imageView.transform=CGAffineTransformMakeScale(2,2);//宽高都放大3倍，这个方法是view的transform属性的方法

//        [_scrollView setZoomScale:1.0];
        return;
        CGPoint touchPoint = [recognizer locationInView:_imageView];
        CGFloat scale = _scrollView.maximumZoomScale;
        CGRect newRect = [self getRectWithScale:scale andCenter:touchPoint];
        [_scrollView zoomToRect:newRect animated:YES];
    }
}

/** 计算点击点所在区域frame */
- (CGRect)getRectWithScale:(CGFloat)scale andCenter:(CGPoint)center{
    CGRect newRect = CGRectZero;
    newRect.size.width =  _scrollView.frame.size.width/scale;
    newRect.size.height = _scrollView.frame.size.height/scale;
    newRect.origin.x = center.x - newRect.size.width * 0.5;
    newRect.origin.y = center.y - newRect.size.height * 0.5;
    
    return newRect;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
