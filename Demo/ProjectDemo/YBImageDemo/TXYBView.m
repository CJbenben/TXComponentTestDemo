//
//  TXYBView.m
//  Demo
//
//  Created by chenxiaojie on 2020/4/21.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import "TXYBView.h"
#import <YBImageBrowser/YBImageBrowser.h>
#import "BaseListCell.h"
#import <YBIBVideoData.h>

@interface TXYBView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *imageAry;

@end

@implementation TXYBView

- (NSArray *)imageAry {
    if (_imageAry == nil) {
        _imageAry = @[@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1317907072,2329659919&fm=26&gp=0.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587462315301&di=ef4ad01f8abf622ebcff8ef6770772ec&imgtype=0&src=http%3A%2F%2Fimage.bitauto.com%2Fdealer%2Fnews%2F100020664%2F08a79f48-96be-4589-b742-a56e74947293.jpg",
                       @"http://pic23.nipic.com/20120919/10785657_204032524191_2.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517824334&di=a6b1fb22560e3bf02b2a98aa3afd0b28&imgtype=jpg&er=1&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F08f790529822720ee889863371cb0a46f31fabb0.jpg"];
    }
    return _imageAry;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BaseListCell.self) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(BaseListCell.self)];
}

- (void)selectedIndex:(NSInteger)index currViewAry:(NSArray *)currViewAry {
    
    NSMutableArray *datas = [NSMutableArray array];
    [self.imageAry enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj hasSuffix:@".mp4"] && [obj hasPrefix:@"http"]) {
            
            // 网络视频
            YBIBVideoData *data = [YBIBVideoData new];
            data.videoURL = [NSURL URLWithString:obj];
            data.projectiveView = currViewAry[idx];
            [datas addObject:data];
         
        } else if ([obj hasSuffix:@".mp4"]) {
            
//            // 本地视频
//            NSString *path = [[NSBundle mainBundle] pathForResource:obj.stringByDeletingPathExtension ofType:obj.pathExtension];
//            YBIBVideoData *data = [YBIBVideoData new];
//            data.videoURL = [NSURL fileURLWithPath:path];
//            data.projectiveView = [self viewAtIndex:idx];
//            [datas addObject:data];
            
        } else if ([obj hasPrefix:@"http"]) {
            
            // 网络图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageURL = [NSURL URLWithString:obj];
            data.projectiveView = currViewAry[idx];
            [datas addObject:data];
            
        } else {
            
            // 本地图片
            YBIBImageData *data = [YBIBImageData new];
            data.imageName = obj;
            data.projectiveView = currViewAry[idx];
            [datas addObject:data];
            
        }
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = index;
    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
    browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    browser.defaultToolViewHandler.topView.hidden = YES;
    [browser show];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(BaseListCell.self) forIndexPath:indexPath];
    cell.data = self.imageAry[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *currViewAry = [NSMutableArray array];
    for (NSInteger index = 0; index<self.imageAry.count; index++) {
        BaseListCell *cell = (BaseListCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [currViewAry addObject:cell.contentImgView];
    }
    [self selectedIndex:indexPath.row currViewAry:currViewAry];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
