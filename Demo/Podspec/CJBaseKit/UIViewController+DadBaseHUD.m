//
//  DadViewController+DadBaseHUD.m
//  Demo
//
//  Created by chenxiaojie on 2019/8/22.
//  Copyright © 2019 ChenJie. All rights reserved.
//

#import "UIViewController+DadBaseHUD.h"
#import "BaseLoadingView.h"
#import "UIView+Toast.h"

@implementation UIViewController (DadBaseHUD)

static CGFloat default_duration     =   2.0;
static NSString *default_position   =   @"center";

- (void)showHUDMessage:(NSString *)message {
    [self showHUDMessage:message duration:default_duration position:default_position title:nil];
}

- (void)showHUDMessage:(NSString *)message duration:(CGFloat)duration {
    [self showHUDMessage:message duration:duration position:default_position title:nil];
}

- (void)showHUDMessage:(NSString *)message position:(NSString *)position {
    [self showHUDMessage:message duration:default_duration position:position title:nil];
}

- (void)showHUDMessage:(NSString *)message duration:(CGFloat)duration position:(NSString *)position title:(NSString *__nullable)title {
    [BaseLoadingView hiddenLoading];
    [[UIApplication sharedApplication].keyWindow makeToast:message duration:duration position:position title:title];
}

- (void)showHUDLoading {
    [BaseLoadingView showLoading];
}

- (void)hideHUDLoading {
    [BaseLoadingView hiddenLoading];
}

@end
