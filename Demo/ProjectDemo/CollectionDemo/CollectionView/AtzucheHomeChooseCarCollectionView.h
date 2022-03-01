//
//  AtzucheHomeChooseCarCollectionView.h
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HomeCollectionType) {
    HomeCollectionTypeChooseCar = 0,
};

@protocol AtzucheHomeCollectionDidSelectDelegate <NSObject>

- (void)atzucheHomeCollectionDidSelectItemAtIndexPath:(NSIndexPath *)indexPath type:(HomeCollectionType)type;
- (void)atzucheHomeCollectionHeaderViewDidSelectAtSection:(NSInteger)section type:(HomeCollectionType)type;
- (void)atzucheHomeCollectionFooterViewDidSelectAtSection:(NSInteger)section type:(HomeCollectionType)type;

@end

@interface AtzucheHomeChooseCarCollectionView : UICollectionView

@property (nonatomic, strong) NSArray *homeChooseCarAry;
@property (assign, nonatomic) id<AtzucheHomeCollectionDidSelectDelegate> homeDelegate;

@end
