//
//  SPBaseLoadingView.h
//  ShopMobile
//
//  Created by chenxiaojie on 2018/12/13.
//  Copyright © 2018年 soubao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseLoadingView : UIView

@property (nonatomic, strong) UIImageView *bgImageView;
+ (instancetype)showLoading;
+ (void)hiddenLoading;

@end

NS_ASSUME_NONNULL_END
