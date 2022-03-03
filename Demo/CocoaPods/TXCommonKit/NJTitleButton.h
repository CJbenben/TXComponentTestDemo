//
//  NJTitleButton.h
//
//  Created by fanxiao on 15-8-11.
//  Copyright (c) 2014年 fanxiao. All rights reserved.
//
/*
 作用：UIButton的image和title位置对调（即title在前，image在后）
 使用方法如下：

     NJTitleButton *btn = [[NJTitleButton alloc]initWithFrame:CGRectMake(10, 20, 115, 30)];
     [btn setupWithFont:[UIFont systemFontOfSize:14]];
     [btn setImage:[UIImage imageNamed:@"greengou_selected"] forState:UIControlStateNormal];
     [btn setTitle:@"上海凹凸租车" forState:UIControlStateNormal];
     [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [self.view addSubview:btn];
 
 如果遇到图片位置问题，使用此方法调整
     self.btn.imageView.frame = CGRectMake(self.btn.titleLabel.right + 10, 0, 15, 12);

 */

#import <UIKit/UIKit.h>

@interface NJTitleButton : UIButton

- (void)setupWithFont:(UIFont *)font;

//不使用该方法时，默认间隙 10
- (void)setTitleAndImageViewGap:(CGFloat)gap;
//不使用该方法时，默认最大
- (void)setTitleLabelMaxWidth:(CGFloat)titleLabelWidthMax;
@end
