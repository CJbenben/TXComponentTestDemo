//
//  AtzucheChooseCarFlowLayout.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheChooseCarFlowLayout.h"

@implementation AtzucheChooseCarFlowLayout

- (instancetype)initAndSize:(CGSize)size {
    if (self = [super init]) {
        self.headerReferenceSize = CGSizeZero;
        self.footerReferenceSize = CGSizeZero;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        self.itemSize = size;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }
    return self;
}

@end
