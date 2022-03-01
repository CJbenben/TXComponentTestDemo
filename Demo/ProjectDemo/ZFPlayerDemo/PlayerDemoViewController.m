//
//  PlayerDemoViewController.m
//  Demo
//
//  Created by chenxiaojie on 2019/11/22.
//  Copyright © 2019 ChenJie. All rights reserved.
//

#import "PlayerDemoViewController.h"
#import "TXCycleScrollView.h"
#import "ZFPlayer.h"
#import "ZFAVPlayerManager.h"
#import "ZFPlayerControlView.h"
#import "UIImageView+ZFCache.h"
#import "ZFUtilities.h"
#import "PlayerBannerModel.h"
#import "ZFAutoPlayerViewController.h"
#import "ZFNotAutoPlayViewController.h"

static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";

@interface PlayerDemoViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) NSArray <NSURL *>*assetURLs;

@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, strong) NSMutableArray *imageAry;

@end

@implementation PlayerDemoViewController

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        CGFloat x = 0;
        CGFloat y = naviHeight;
        CGFloat w = CGRectGetWidth(self.view.frame);
        CGFloat h = w*9/16;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _scrollView.backgroundColor = [UIColor systemRedColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 200);
    }
    return _scrollView;
}

- (NSMutableArray *)dataAry {
    if (_dataAry == nil) {
        _dataAry = [NSMutableArray array];
    }
    return _dataAry;
}

- (NSMutableArray *)imageAry {
    if (_imageAry == nil) {
        _imageAry = [NSMutableArray array];
    }
    return _imageAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.rightBtnTitle = @"Push";
    
//    CGRect scrollViewF = CGRectMake(0, naviHeight, SCREEN_WIDTH, 200);
//    CGRect imageViewF = CGRectMake(0, 0, SCREEN_WIDTH, 200);
//    NSArray *imagePaths = @[kVideoCover, kVideoCover, kVideoCover, kVideoCover];
//    TXCycleScrollView *cycleScrollView = [TXCycleScrollView atzucheCycleScrollViewFrame:scrollViewF imageViewFrame:imageViewF radius:0 imagePaths:imagePaths animationDuration:0];
//    [self.view addSubview:cycleScrollView];
    
    PlayerBannerModel *bannerModel1 = [[PlayerBannerModel alloc] init];
    bannerModel1.type = 2;
    bannerModel1.url = kVideoCover;
    bannerModel1.videoUrl = self.assetURLs[0];
    [self.dataAry addObject:bannerModel1];
    
    PlayerBannerModel *bannerModel2 = [[PlayerBannerModel alloc] init];
    bannerModel2.type = 1;
    bannerModel2.url = kVideoCover;
    [self.dataAry addObject:bannerModel2];
    
    PlayerBannerModel *bannerModel3 = [[PlayerBannerModel alloc] init];
    bannerModel3.type = 2;
    bannerModel3.url = kVideoCover;
    bannerModel3.videoUrl = self.assetURLs[1];
    [self.dataAry addObject:bannerModel3];
    
    [self.view addSubview:self.scrollView];
    for (NSInteger i = 0; i<self.dataAry.count; i++) {
        UIImageView *containerView = [UIImageView new];
        containerView.userInteractionEnabled = YES;
        
        containerView.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, self.scrollView.height);
        [containerView setImageWithURLString:kVideoCover placeholder:[ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)]];
        [self.scrollView addSubview:containerView];
        [self.imageAry addObject:containerView];
        
        CGFloat w = 44;
        CGFloat h = w;
        CGFloat x = (CGRectGetWidth(containerView.frame)-w)/2;
        CGFloat y = (CGRectGetHeight(containerView.frame)-h)/2;
        
        UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        playBtn.frame = CGRectMake(x, y, w, h);
        [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
        playBtn.tag = 200 + i;
        [containerView addSubview:playBtn];
    }

    
    
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    playerManager.shouldAutoPlay = YES;
    
    UIImageView *imageview = safeObjectTxAtIndex(self.imageAry, 0);
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:imageview];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
    self.player.disableGestureTypes = ZFPlayerDisableGestureTypesPan;
    
    @zf_weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        kAPPDelegate.allowOrentitaionRotation = isFullScreen;
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @zf_strongify(self)
        if (!self.player.isLastAssetURL) {
            [self.player playTheNext];
            NSString *title = [NSString stringWithFormat:@"视频标题%zd",self.player.currentPlayIndex];
            [self.controlView showTitle:title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
        } else {
            [self.player stop];
        }
    };
    
    self.player.assetURLs = self.assetURLs;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZFAutoPlayerViewController *autoPlayerVC = [[ZFAutoPlayerViewController alloc] init];
//    ZFNotAutoPlayViewController *autoPlayerVC = [[ZFNotAutoPlayViewController alloc] init];
    [self.navigationController pushViewController:autoPlayerVC animated:YES];
}

- (void)changeVideo:(UIButton *)sender {
    NSString *URLString = @"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4";
    self.player.assetURL = [NSURL URLWithString:URLString];
    [self.controlView showTitle:@"Apple" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
}

- (void)playClick:(UIButton *)sender {
    [self.player playTheIndex:0];
    [self.controlView showTitle:@"视频标题" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
}

- (void)nextClick:(UIButton *)sender {
    if (!self.player.isLastAssetURL) {
        [self.player playTheNext];
        NSString *title = [NSString stringWithFormat:@"视频标题%zd",self.player.currentPlayIndex];
        [self.controlView showTitle:title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
    } else {
        NSLog(@"最后一个视频了");
    }
}

- (void)naviRightBtnAction {
//    HMAutoPlayerViewController *vc = [[HMAutoPlayerViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
        _controlView.prepareShowControlView = YES;
    }
    return _controlView;
}

- (NSArray<NSURL *> *)assetURLs {
    if (!_assetURLs) {
            _assetURLs = @[[NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"],
          [NSURL URLWithString:@"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4"],
          [NSURL URLWithString:@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/peter/mac-peter-tpl-cc-us-2018_1280x720h.mp4"],
          [NSURL URLWithString:@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/grimes/mac-grimes-tpl-cc-us-2018_1280x720h.mp4"],
          [NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/6/H/9/EDJTRBEH9/SD/EDJTRBEH9-mobile.mp4"],
          [NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/6/9/R/EDJTRAD9R/SD/EDJTRAD9R-mobile.mp4"],
          [NSURL URLWithString:@"http://www.flashls.org/playlists/test_001/stream_1000k_48k_640x360.m3u8"],
          [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-video/7_517c8948b166655ad5cfb563cc7fbd8e.mp4"],
          [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/68_20df3a646ab5357464cd819ea987763a.mp4"],
          [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/118_570ed13707b2ccee1057099185b115bf.mp4"],
          [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/15_ad895ac5fb21e5e7655556abee3775f8.mp4"],
          [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/12_cc75b3fb04b8a23546d62e3f56619e85.mp4"],
          [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/5_6d3243c354755b781f6cc80f60756ee5.mp4"],
                           [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-movideo/11233547_ac127ce9e993877dce0eebceaa04d6c2_593d93a619b0.mp4"]];
    }
    return _assetURLs;
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
