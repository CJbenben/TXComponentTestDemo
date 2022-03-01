//
//  TXCollectionViewController.m
//  Demo
//
//  Created by chenxiaojie on 2020/3/1.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import "TXCollectionViewController.h"
#import "TXWaterFallLayout.h"
#import "TXCollectionViewCell.h"
#import "TXAutoCollectionViewCell.h"
#import "TXCollectionView.h"

@interface TXCollectionViewController ()<TXWaterFallLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation TXCollectionViewController

static NSString *reuseID        = @"TXCollectionViewCell";
static NSString *reuseID2        = @"TXAutoCollectionViewCell";

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, SCREEN_HEIGHT - naviHeight)];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitleL.text = @"瀑布流";
    
    [self.view addSubview:self.scrollView];
    // 瀑布流
    TXWaterFallLayout * layout = [[TXWaterFallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    layout.columnCount = 2;
    layout.columnSpacing = 10;
    layout.lineSpacing = 20;
    layout.delegate = self;
    TXCollectionView *collectionView = [[TXCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - naviHeight) collectionViewLayout:layout];
    collectionView.scrollEnabled = NO;
    [self.scrollView addSubview:collectionView];
    [collectionView layoutIfNeeded];
    CGFloat height = collectionView.collectionViewLayout.collectionViewContentSize.height;
    collectionView.height = height;
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, height)];
    
//    // 自适应
//    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc] init];
//    layout2.estimatedItemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 200);
//
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, SCREEN_HEIGHT-naviHeight) collectionViewLayout:layout2];
//    collectionView.backgroundColor = [UIColor lightGrayColor];
//    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TXCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseID];
//    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TXAutoCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseID2];
//    collectionView.dataSource = self;
//    collectionView.delegate = self;
//    [self.view addSubview:collectionView];
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 2;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return 20;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
////    if (indexPath.section == 0) {
////        TXCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
////        cell.backgroundColor = [UIColor redColor];
////        return cell;
////    }
//    TXAutoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID2 forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor greenColor];
//    return cell;
    
}

- (CGFloat)waterFallLayout:(TXWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth {
//    if (index % 2 == 0) {
//        return 100;
//    } else {
//        return 150;
//    }
    return arc4random() % 100 + 100;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
