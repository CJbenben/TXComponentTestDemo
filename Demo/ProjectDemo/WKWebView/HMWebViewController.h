//
//  HMWebViewController.h
//  LYHM
//
//  Created by chenxiaojie on 2019/9/5.
//  Copyright © 2019 chenxiaojie. All rights reserved.
//

#import "TXBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMWebViewController : TXBaseViewController

@property (nonatomic, strong) NSString *naviTitle;

/**
 @brief 使用 wkwebview 加载外部网页地址(默认不隐藏导航栏)
 @param urlStr          外部网页地址
 */
- (void)loadWebURLString:(NSString *)urlStr;

/**
 @brief 使用 wkwebview 加载外部网页地址(默认不隐藏导航栏)
 @param urlStr          外部网页地址
 @param naviTitle       导航栏标题，不传默认取 h5 的 title
 */
- (void)loadWebURLString:(NSString *)urlStr naviTitle:(NSString *)naviTitle;

/**
 @brief 使用 wkwebview 加载外部网页地址(默认不隐藏导航栏)
 @param urlStr              外部网页地址
 @param naviTitle           导航栏标题，不传默认取 h5 的 title
 @param isHiddenNavi        是否隐藏导航栏（1：隐藏 0：显示 默认0）
 @param isHiddenStatusBar   是否隐藏状态栏（1：隐藏 0：显示 默认0）
 @param statusBarColor      状态栏颜色（1：白色 0：黑色 默认0）
 */
- (void)loadWebURLString:(NSString *)urlStr naviTitle:(NSString *__nullable)naviTitle isHiddenNavi:(BOOL)isHiddenNavi isHiddenStatusBar:(BOOL)isHiddenStatusBar statusBarColor:(BOOL)statusBarColor;

/**
 @brief 加载 html 标签字符串
 @param htmlStr         html 字符串
 */
- (void)loadWebHTMLSring:(NSString *)htmlStr;

/**
 @brief 加载本地 html 文件
 @param suffix          本地 html 文件名
 */
- (void)loadLocalPathURLWithSuffix:(NSString *)suffix;

/**
@brief 清除 webview 缓存
*/
+ (void)clearWebCache;

/**
@brief 开启定位权限后获取定位
*/
- (void)refreshLocationInfo;

@end

NS_ASSUME_NONNULL_END
