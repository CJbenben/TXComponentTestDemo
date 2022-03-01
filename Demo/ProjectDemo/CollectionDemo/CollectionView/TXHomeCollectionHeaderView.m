//
//  TXHomeCollectionHeaderView.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "TXHomeCollectionHeaderView.h"

@implementation TXHomeCollectionHeaderView

- (UILabel *)leftL {
    if (_leftL == nil) {
        _leftL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 50)];
        _leftL.text = @"精选优车";
    }
    return _leftL;
}

- (NJTitleButton *)allBtn {
    if (_allBtn == nil) {
        _allBtn = [[NJTitleButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 0, 60, 50)];
        [_allBtn setupWithFont:[UIFont systemFontOfSize:14]];
        [_allBtn setImage:[UIImage imageNamed:@"greengou_selected"] forState:UIControlStateNormal];
        [_allBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _allBtn;
}

- (instancetype)initWithHeaderViewWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.leftL];
        [self addSubview:self.allBtn];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)gr {
    if (self.headerBlock) {
        self.headerBlock();
    }
}

@end
