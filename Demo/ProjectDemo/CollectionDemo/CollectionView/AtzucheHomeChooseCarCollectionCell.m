//
//  AtzucheHomeChooseCarCollectionCell.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheHomeChooseCarCollectionCell.h"

@implementation AtzucheHomeChooseCarCollectionCell

- (UIImageView *)carImageV {
    if (_carImageV == nil) {
        _carImageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width - 10, (self.frame.size.width - 10) * 2/3.0)];
        _carImageV.userInteractionEnabled = YES;
        _carImageV.layer.cornerRadius = 2.0;
        _carImageV.layer.masksToBounds = YES;
    }
    return _carImageV;
}

- (UILabel *)carConfigL {
    if (_carConfigL == nil) {
        _carConfigL = [[UILabel alloc] initWithFrame:CGRectMake(self.carImageV.x, self.carImageV.bottom + 10, self.carImageV.width, 25)];
        _carConfigL.text = @"宝马 2系 2.0T";
    }
    return _carConfigL;
}

- (UILabel *)carCardL {
    if (_carCardL == nil) {
        _carCardL = [[UILabel alloc] initWithFrame:CGRectMake(self.carImageV.x, self.carConfigL.bottom, self.carImageV.width, 20)];
        _carCardL.text = @"沪A***56";
    }
    return _carCardL;
}

- (UILabel *)carPriceL {
    if (_carPriceL == nil) {
        _carPriceL = [[UILabel alloc] initWithFrame:CGRectMake(self.carImageV.x, self.carCardL.bottom, self.carImageV.width, 45)];
        _carPriceL.text = @"$258/天";
        _carPriceL.backgroundColor = [UIColor yellowColor];
    }
    return _carPriceL;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.carImageV];
        [self addSubview:self.carConfigL];
        [self addSubview:self.carCardL];
        [self addSubview:self.carPriceL];
    }
    return self;
}

@end
