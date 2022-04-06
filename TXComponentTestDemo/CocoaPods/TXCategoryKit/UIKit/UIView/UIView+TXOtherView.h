//
//  UIView+TXOtherView.h
//  Demo
//
//  Created by chenxiaojie on 2022/3/2.
//  Copyright © 2022 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TXOtherView) <CAAnimationDelegate>

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

NS_ASSUME_NONNULL_END
