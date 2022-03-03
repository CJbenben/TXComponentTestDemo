//
//  TXDadView.m
//  SPHKProjectDev
//
//  Created by yue on 2018/11/16.
//  Copyright © 2018年 chenxiaojie. All rights reserved.
//

#import "TXDadView.h"

@implementation TXDadView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
