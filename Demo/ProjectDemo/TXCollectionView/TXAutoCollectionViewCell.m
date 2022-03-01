//
//  TXAutoCollectionViewCell.m
//  Demo
//
//  Created by chenxiaojie on 2020/3/1.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import "TXAutoCollectionViewCell.h"

@implementation TXAutoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    
    [self setNeedsLayout];
    
    [self layoutIfNeeded];
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    
    CGRect cellFrame = layoutAttributes.frame;
    
    cellFrame.size.height= size.height;
    
    layoutAttributes.frame= cellFrame;
    
    return layoutAttributes;
    
}

@end
