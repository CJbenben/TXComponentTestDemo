//
//  SPHKDadView.h
//  SPHKProjectDev
//
//  Created by yue on 2018/11/16.
//  Copyright © 2018年 chenxiaojie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJCommonKit.h"
#import "CJCategoryKit.h"
#import "Masonry.h"

@interface DadView : UIView

/** 关于 iPhone X 适配距离顶部边距 */
@property (nonatomic, assign) CGFloat iphonexNaviPadding;
/** 关于 iPhone X 适配距离底部边距 */
@property (nonatomic, assign) CGFloat iphonexBottomPadding;

@property (strong, nonatomic) UIView *customLineV;

@end
