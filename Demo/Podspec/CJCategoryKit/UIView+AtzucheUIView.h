//
//  UIView+AtzucheUIView.h
//  Autoyol
//
//  Created by chenxioajie on 14/11/14.
//  Copyright (c) 2014年 chenxiaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

/*本地化转换*/
#undef L
#define L(key) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

@interface UIView (AtzucheUIView) <CAAnimationDelegate>

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;

@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;

- (void)settingLayerView:(UIView *)originalView color:(UIColor *)color radius:(CGFloat)radius;

- (void)removeAllSubviews;
- (UIViewController *)viewController;

//like airbnb
- (void)setAnchorPoint:(CGPoint)point;
-(UIViewController *)getSuperViewController;
//一级界面推到下级界面动画
-(CATransition *)getPushTransition;
//从上到下覆盖界面
-(CATransition *)getPopTransition;

@end
