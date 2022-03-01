//
//  AtzucheRefreshStateHeader.h
//  Demo
//
//  Created by ChenJie on 2018/4/16.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

/**
 兼容 iPhone X 下拉刷新，顶部文字被遮挡问题。
 实现方案：增加顶部高度，修改 label.y
 */
@interface AtzucheRefreshStateHeader : MJRefreshStateHeader

@end
