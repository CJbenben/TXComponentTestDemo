//
//  UIButton+TXKitButton.m
//  ShopMobile
//
//  Created by chenxiaojie on 2018/10/15.
//  Copyright © 2018年 soubao. All rights reserved.
//

#import "UIButton+TXKitButton.h"
#import <objc/runtime.h>
#import "Aspects.h"

@implementation UIButton (TXKitButton)
- (void)ln_expandHitBoundsWithEdgeInsets:(UIEdgeInsets)insets {
    id<AspectToken> token = objc_getAssociatedObject(self, @selector(pointInside:withEvent:));
    [token remove];
    token = [self aspect_hookSelector:@selector(pointInside:withEvent:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info) {
        CGRect originFrame = self.bounds;
        UIEdgeInsets relativeInsets = UIEdgeInsetsMake(-insets.top, -insets.left, -insets.bottom, -insets.right);
        CGRect hitFrame = UIEdgeInsetsInsetRect(originFrame, relativeInsets);
        CGPoint hitPoint = [[info arguments][0] CGPointValue];
        BOOL ret = CGRectContainsPoint(hitFrame, hitPoint);
        [[info originalInvocation] setReturnValue:&ret];
    } error:NULL];
    objc_setAssociatedObject(self, @selector(pointInside:withEvent:), token, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color{
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
       
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
            
        }else{
        
            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}

@end
