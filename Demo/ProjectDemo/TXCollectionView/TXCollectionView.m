//
//  TXCollectionView.m
//  Demo
//
//  Created by chenxiaojie on 2020/3/3.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import "TXCollectionView.h"
#import "HMHomeLikeCollectionViewCell.h"
#import "CJCommonKit.h"
#import "CJCategoryKit.h"
#import "Masonry.h"
#import "UIViewController+DadBaseHUD.h"

@interface TXCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation TXCollectionView

static NSString *homeReuseID        = @"HMHomeLikeCollectionViewCell";

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    return [self initWithFrame:frame collectionViewLayout:layout hiddenHeaderView:NO];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout hiddenHeaderView:(BOOL)hiddenHeaderView {
    return [self initWithFrame:frame collectionViewLayout:layout hiddenHeaderView:hiddenHeaderView isFromHome:NO];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout hiddenHeaderView:(BOOL)hiddenHeaderView isFromHome:(BOOL)isFromHome {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
    
        [self registerNib:[UINib nibWithNibName:NSStringFromClass([HMHomeLikeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:homeReuseID];
        
        self.dataSource = self;
        self.delegate = self;
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.userInteractionEnabled = YES;
        self.scrollEnabled = YES;
        
        self.backgroundColor = [UIColor clearColor];
//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        self.showsHorizontalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateNormal;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath = %@", indexPath);
    HMHomeLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeReuseID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //[self.homeDelegate homeCollectionView:self didSelectItemAtIndexPath:indexPath type:HomeCollectionTypeChooseCar];
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
//        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader forIndexPath:indexPath];
//        // 此处headerView 可能会产生复用，所以在使用之前要将其中原有的子视图移除掉
//        // 参考文章：http://www.jianshu.com/p/e1cc2d256d20
//        for (UIView *view in headerView.subviews) {
//            [view removeFromSuperview];
//        }
//        HMLikeHeaderView *header = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HMLikeHeaderView class]) owner:nil options:nil] firstObject];
//        header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
//        //header.leftL.text = self.indexCarModel.title;
//        if (self.isFromHome) {
////            header.titleL.text = @"为你推荐";
////            header.tipL.text = @"R E C O M M E N D  T O  Y O U";
//            header.backgroundColor = [UIColor clearColor];
//            header.titleL.hidden = header.tipL.hidden = header.centerLineV.hidden = header.bottomLineV.hidden = YES;
//            header.centerIV.hidden = NO;
//        } else {
//            header.backgroundColor = [UIColor whiteColor];
//            header.titleL.hidden = header.tipL.hidden = header.centerLineV.hidden = header.bottomLineV.hidden = NO;
//            header.centerIV.hidden = YES;
//        }
//        [headerView addSubview:header];
//        return headerView;
//    }
//    return nil;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.isFromHome) {
        CGFloat imageViewH = (SCREEN_WIDTH_HALF - 10);
        return CGSizeMake(SCREEN_WIDTH_HALF, imageViewH + 114/*266*/);
//    }
//    CGFloat imageViewH = SCREEN_WIDTH_HALF;
//    return CGSizeMake(SCREEN_WIDTH_HALF, imageViewH + 88/*250*/);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    if (self.hiddenHeaderView) {
        return CGSizeZero;
//    } else {
//        return CGSizeMake(SCREEN_WIDTH, 60);
//    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    self.scrollCallBackBlock(scrollView.contentOffset.y);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
