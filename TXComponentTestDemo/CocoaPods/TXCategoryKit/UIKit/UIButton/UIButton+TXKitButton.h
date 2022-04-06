//
//  UIButton+SPKitButton.h
//  ShopMobile
//
//  Created by chenxiaojie on 2018/10/15.
//  Copyright © 2018年 soubao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TXKitButton)

- (void)ln_expandHitBoundsWithEdgeInsets:(UIEdgeInsets)insets;

/**
 @brief 倒计时按钮
 @param timeLine  倒计时总时间
 @param title     还没倒计时的title
 @param subTitle  倒计时的子名字 如：秒后重试
 @param mColor    还没倒计时的背景颜色
 @param color     倒计时的背景颜色
*/
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

@end
