//
//  DadViewController+DadBaseHUD.h
//  Demo
//
//  Created by chenxiaojie on 2019/8/22.
//  Copyright © 2019 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DadBaseHUD)

/**
 @brief 展示提示用户消息 默认 2 秒消失
 @param message 提示用户内容
 */
- (void)showHUDMessage:(NSString *)message;

/**
 @brief 展示提示用户消息
 @param message     提示用户内容（必传）
 @param duration    提示消失时间（默认 2 秒）
 */
- (void)showHUDMessage:(NSString *)message duration:(CGFloat)duration;
/**
 @brief 展示提示用户消息
 @param message     提示用户内容（必传）
 @param position    提示展示位置（默认 center，可传 top,center,bottom）
 */
- (void)showHUDMessage:(NSString *)message position:(NSString *)position;
/**
 @brief 展示提示用户消息
 @param message     提示用户内容（必传）
 @param duration    提示消失时间（默认 2 秒）
 @param position    提示展示位置（默认 center，可传 top,center,bottom）
 @param title       提示标题
 */
- (void)showHUDMessage:(NSString *)message duration:(CGFloat)duration position:(NSString *)position title:(NSString *__nullable)title;

/**
 @brief 显示 自定义加载 loading.json 动画
 */
- (void)showHUDLoading;
/**
 @brief 隐藏 自定义加载 loading.json 动画
 */
- (void)hideHUDLoading;

@end

NS_ASSUME_NONNULL_END
