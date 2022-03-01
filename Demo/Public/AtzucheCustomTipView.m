//
//  AtzucheCustomTipView.m
//  Demo
//
//  Created by ChenJie on 2018/6/4.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheCustomTipView.h"

@interface AtzucheCustomTipView()

@property (nonatomic, strong) UIImageView *leftIV;
@property (nonatomic, strong) UILabel *tipL;
@property (nonatomic, strong) UIImageView *rightArrowIV;

@property (assign, nonatomic) BOOL isHaveTitle;
@property (assign, nonatomic) BOOL isHaveImage;
@property (nonatomic, assign) BOOL isHaveArrow;

@end

@implementation AtzucheCustomTipView

- (UIImageView *)leftIV {
    if (_leftIV == nil) {
        _leftIV = [[UIImageView alloc] init];
        _leftIV.userInteractionEnabled = YES;
        _leftIV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftIV;
}

- (instancetype)initWithFrame:(CGRect)frame leftImageName:(NSString *)imageName tipTitle:(NSString *)tipTitle isHaveArrow:(BOOL)isHaveArrow {
    if (self = [super initWithFrame:frame]) {
        if (imageName.length != 0) {
            _isHaveImage = YES;
        }
        if (tipTitle.length != 0) {
            _isHaveTitle = YES;
        }
        _isHaveArrow = isHaveArrow;
        
        [self addSubview:self.leftIV];
        [self addSubview:self.tipL];
        if (isHaveArrow) {
            [self addSubview:self.rightArrowIV];
        }
        
        [self settingFrame];
    }
    return self;
}

- (void)settingFrame {
    
    //CGFloat imageWidth = 20;
    
    
    CGFloat tipLMaxW = SCREEN_WIDTH - (self.isHaveImage?40 : 20) - (self.isHaveArrow?30 : 0);
    
    CGSize tipLSize = [self cjSizeWithString:self.tipL.text font:self.tipL.font maxSize:CGSizeMake(tipLMaxW, CGFLOAT_MAX)];
    
    self.tipL.frame = CGRectMake(self.isHaveImage?40 : 20, 10, tipLSize.width, tipLSize.height);
    
    
}

- (CGSize)cjSizeWithString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *dic = @{NSFontAttributeName:font};  //指定字号
    CGRect rect = [string boundingRectWithSize:maxSize/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
