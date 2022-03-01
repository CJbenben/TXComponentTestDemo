//
//  XKTargetTableView.h
//  Demo
//
//  Created by chenxiaojie on 2020/8/12.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XKTargetTableView : UITableView

///可否滑动
@property (nonatomic,assign) BOOL canSlide;
///滑动block通知
@property (nonatomic,copy) void (^slideDragBlock)(void);

@end

NS_ASSUME_NONNULL_END
