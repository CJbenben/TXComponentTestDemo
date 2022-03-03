//
//  TXDadViewController.h
//  Demo
//
//  Created by ChenJie on 2018/6/1.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXDadViewController : UIViewController

@property (strong, nonatomic) UIView *naviView;
/** 导航titile */
@property (strong, nonatomic) UILabel *naviTitleL;
/** 右导航可点击按钮文字 */
@property (strong, nonatomic) NSString *rightBtnTitle;
/** 右导航可点击按钮文字颜色 默认值 rgb(51, 51, 51) */
@property (strong, nonatomic) UIColor *rightBtnTitleColor;
/** 右导航可点击按钮背景图片 */
@property (strong, nonatomic) NSString *rightBtnImage;
/** 设置返回按钮图片 */
@property (strong, nonatomic) UIImage *backImage;
/** 是否隐藏导航底部线条(默认显示) */
@property (assign, nonatomic) BOOL isHiddenBottomLine;

/**
 @brief 拨打电话
 @param phoneNumber     电话号码
 */
- (void)hkCallPhoneWithTel:(NSString *)phoneNumber;

///**
// @brief 跳转下一个页面
// @param media_type  跳转类型
// @param title       webview 的 title
// @param media_param 跳转参数
// */
//- (void)jumpPushNextPageWithMediaType:(NSString *)media_type title:(NSString *)title mediaParam:(NSString *)media_param;
//
//- (void)exception:(NSInteger)errorCode message:(NSString *)msg;

@end
