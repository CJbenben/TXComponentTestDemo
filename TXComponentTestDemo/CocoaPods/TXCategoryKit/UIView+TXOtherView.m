//
//  UIView+TXOtherView.m
//  Demo
//
//  Created by chenxiaojie on 2022/3/2.
//  Copyright © 2022 ChenJie. All rights reserved.
//

#import "UIView+TXOtherView.h"

@implementation UIView (TXOtherView)

- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController *)viewController
{
    id nextResponder = [self nextResponder];
    if ( [nextResponder isKindOfClass:[UIViewController class]] )
    {
        return (UIViewController *)nextResponder;
    }
    else
    {
        return nil;
    }
}


- (void)setAnchorPoint:(CGPoint)anchorPoint {
    UIView *view = self;
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
    
}
-(UIViewController *)getSuperViewController
{
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//变黑
    UIView *view;
    UIViewController *superVc;
    for (int i=0; i<100; i++) {
        if(view ==nil)
        {
            view = self.superview;
        }
        else
        {
            view = view.superview;
        }
        if(view.viewController!=nil)
        {
            superVc = view.viewController;
            break;
        }
        else
        {
            i ++;
        }
        
    }
    return superVc;
}
//一级界面推到下级界面动画
-(CATransition *)getPushTransition
{
    CATransition *transition = [CATransition animation];
    transition.duration =0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    return transition;
}
//从上到下覆盖界面
-(CATransition *)getPopTransition
{
    CATransition *transition = [CATransition animation];
    transition.duration =1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"rippleEffect";
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;

    return transition;
}

@end
