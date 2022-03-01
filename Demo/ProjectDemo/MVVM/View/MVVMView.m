//
//  MVVMView.m
//  Demo
//
//  Created by chenxiaojie on 2018/11/23.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "MVVMView.h"

@interface MVVMView ()

@property (strong, nonatomic) UILabel *titleL;
@property (strong, nonatomic) UIButton *btn;

@end
@implementation MVVMView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 200, 40)];
        self.titleL.backgroundColor = [UIColor lightGrayColor];
        self.titleL.textAlignment = NSTextAlignmentCenter;
        self.titleL.text = @"text";
        [self addSubview:self.titleL];
        
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame = CGRectMake(100, 120, 100, 40);
        [self.btn setTitle:@"getHttpData" forState:UIControlStateNormal];
        self.btn.backgroundColor = [UIColor yellowColor];
        [self.btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
        
        
        self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 170, self.frame.size.width, 400) style:UITableViewStylePlain];
        [self addSubview:self.tableview];
        
    }
    return self;
}

- (void)btnAction {
    if ([self.delegate respondsToSelector:@selector(mvvmViewBtnAction)]) {
        [self.delegate mvvmViewBtnAction];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
