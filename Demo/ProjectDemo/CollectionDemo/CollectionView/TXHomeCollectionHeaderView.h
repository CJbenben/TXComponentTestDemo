//
//  TXHomeCollectionHeaderView.h
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJTitleButton.h"

typedef void (^HeaderBlock)(void);

@interface TXHomeCollectionHeaderView : UIView

@property (nonatomic, strong) UILabel *leftL;
@property (nonatomic, strong) NJTitleButton *allBtn;

@property (nonatomic, copy) HeaderBlock headerBlock;

- (instancetype)initWithHeaderViewWithFrame:(CGRect)frame;

@end
