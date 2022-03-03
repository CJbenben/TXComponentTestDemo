//
//  NJTitleButton.m
//
//  Created by fanxiao on 15-8-11.
//  Copyright (c) 2014年 fanxiao. All rights reserved.
//

#import "NJTitleButton.h"
//#import <Availability.h>

@interface NJTitleButton ()
@property (nonatomic, strong) UIFont *myFont;
@property (nonatomic, assign) CGFloat imageX;
/** 图片和文本之间的间隙 */
@property (nonatomic, assign) CGFloat gap;
/** 文本的最大宽度 */
@property (nonatomic,assign) CGFloat titleLabelWidthMax;

@end

@implementation NJTitleButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super initWithCoder:aDecoder]) {
        self.gap = 10;
        self.titleLabelWidthMax = MAXFLOAT;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.gap = 10;
        self.titleLabelWidthMax = MAXFLOAT;
    }
    return self;
}


- (void)setupWithFont:(UIFont *)font
{
    // 记录按钮标题的字体
    self.myFont = font;
    // 设置标题的字体
    self.titleLabel.font = self.myFont;
    // 设置按钮的图片显示的内容默认为剧中(为了不拉伸)
    self.imageView.contentMode = UIViewContentModeCenter;
}

- (void)setTitleAndImageViewGap:(CGFloat)gap
{
    self.gap = gap;
}

- (void)setTitleLabelMaxWidth:(CGFloat)titleLabelWidthMax
{
    self.titleLabelWidthMax = titleLabelWidthMax;
}

// 用于返回按钮上标题的位置, 传入按钮的rect
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleH = contentRect.size.height;
    // 获取当前按钮上的文字
//    [self titleForState:UIControlStateNormal];
    NSString *title = self.currentTitle;
    CGSize maxSize = CGSizeMake(self.titleLabelWidthMax, MAXFLOAT);
    NSMutableDictionary *md = [NSMutableDictionary dictionary];

    md[NSFontAttributeName] = self.myFont;
    
    // 计算文字的范围
    CGFloat titleW =  0;
    // 判断是否是xcode5 , 如果是就编译一下代码, 如果不是就不编译
#ifdef __IPHONE_7_0
    CGRect titleRect = [title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:md context:nil];
    titleW = titleRect.size.width;
#else
    // XCODE4
    CGSize titleSize = [title sizeWithFont:self.myFont];
    titleW = titleSize.width;
#endif
    CGFloat difX = (contentRect.size.width - titleW - 15) > 0 ? (contentRect.size.width - titleW - 15) : 0;
    CGFloat titleX = difX * 0.5;
    self.imageX = titleX + titleW + self.gap;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageW = 15;
    // 图片的X = 按钮的宽度 - 图片宽度
    return CGRectMake(self.imageX, imageY, imageW, imageH);
}
@end
