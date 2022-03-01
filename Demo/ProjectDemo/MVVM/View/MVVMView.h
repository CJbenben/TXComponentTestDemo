//
//  MVVMView.h
//  Demo
//
//  Created by chenxiaojie on 2018/11/23.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVVMViewModel.h"

@protocol MVVMViewDelegate <NSObject>

- (void)mvvmViewBtnAction;

@end
NS_ASSUME_NONNULL_BEGIN

@interface MVVMView : UIView

@property (strong, nonatomic) UITableView *tableview;
@property (strong, nonatomic) NSString *titleStr;
@property (assign, nonatomic) id<MVVMViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
