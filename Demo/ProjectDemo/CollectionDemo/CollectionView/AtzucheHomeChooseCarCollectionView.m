//
//  AtzucheHomeChooseCarCollectionView.m
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheHomeChooseCarCollectionView.h"
#import "AtzucheHomeChooseCarCollectionCell.h"
#import "TXHomeCollectionHeaderView.h"

@interface AtzucheHomeChooseCarCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation AtzucheHomeChooseCarCollectionView

static NSString *reuseID        = @"AtzucheHomeChooseCarCollectionCell";
static NSString *reuseHeader    = @"AtzucheHomeChooseCarCollectionCellHeader";

- (void)setHomeChooseCarAry:(NSArray *)homeChooseCarAry {
    _homeChooseCarAry = homeChooseCarAry;
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self registerClass:[AtzucheHomeChooseCarCollectionCell class] forCellWithReuseIdentifier:reuseID];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader];
        
        self.dataSource = self;
        self.delegate = self;
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.userInteractionEnabled = YES;
        self.scrollEnabled = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.showsHorizontalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateNormal;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.homeChooseCarAry.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.homeChooseCarAry objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AtzucheHomeChooseCarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    if (_homeChooseCarAry.count) {
        [cell.carImageV sd_setImageWithURL:[NSURL URLWithString:[[self.homeChooseCarAry objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]] placeholderImage:nil];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader forIndexPath:indexPath];
        // 此处headerView 可能会产生复用，所以在使用之前要将其中原有的子视图移除掉
        // 参考文章：http://www.jianshu.com/p/e1cc2d256d20
        for (UIView *view in headerView.subviews) {
            [view removeFromSuperview];
        }
        TXHomeCollectionHeaderView *header = [[TXHomeCollectionHeaderView alloc] initWithHeaderViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        header.backgroundColor = [UIColor cyanColor];
        header.headerBlock = ^() {
            [self.homeDelegate atzucheHomeCollectionHeaderViewDidSelectAtSection:indexPath.section type:HomeCollectionTypeChooseCar];
        };
        [headerView addSubview:header];
        return headerView;
//    } else if ([kind isEqual:UICollectionElementKindSectionFooter]) {
//        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooter forIndexPath:indexPath];
//        for (UIView *view in footerView.subviews) {
//            [view removeFromSuperview];
//        }
//        ZSHMainCollectionHeaderAndFooterView *footer = [[ZSHMainCollectionHeaderAndFooterView alloc] initWithFooterViewWithFrame:CGRectMake(0, 0, ScreenWidth, home_product_foot_H) type:HomeModuleTypeProduct];
//        footer.hidden = homeModel.cat_id == 0 ? YES : NO;
//        footer.footerBtn.tag = indexPath.section;
//        footer.moreBtnBlock = ^(NSInteger section){
//            [self.homeDelegate collectionFooterViewDidSelectAtSection:section type:HomeModuleTypeProduct];
//        };
//        [footerView addSubview:footer];
//        return footerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.homeDelegate atzucheHomeCollectionDidSelectItemAtIndexPath:indexPath type:HomeCollectionTypeChooseCar];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(SCREEN_WIDTH, 50);
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

@end
