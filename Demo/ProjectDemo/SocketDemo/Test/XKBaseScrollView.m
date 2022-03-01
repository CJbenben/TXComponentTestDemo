
//
//  XKBaseScrollView.m
//  Demo
//
//  Created by chenxiaojie on 2020/8/12.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import "XKBaseScrollView.h"

@implementation XKBaseScrollView

//是否支持多时候触发，这里返回YES
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
