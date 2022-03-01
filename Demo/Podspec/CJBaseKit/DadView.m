//
//  SPHKDadView.m
//  SPHKProjectDev
//
//  Created by yue on 2018/11/16.
//  Copyright © 2018年 chenxiaojie. All rights reserved.
//

#import "DadView.h"

@implementation DadView

- (UIView *)customLineV {
    if (_customLineV == nil) {
        _customLineV = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 1, SCREEN_WIDTH, 1)];
        _customLineV.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    }
    return _customLineV;
}

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		
        self.iphonexNaviPadding = isQiLiuHai ? 24 : 0;
        self.iphonexBottomPadding = isQiLiuHai ? 34 : 0;
		
	}
	return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iphonexNaviPadding = isQiLiuHai ? 24 : 0;
    self.iphonexBottomPadding = isQiLiuHai ? 34 : 0;
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
