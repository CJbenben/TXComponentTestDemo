//
//  AViewController.m
//  Demo
//
//  Created by chenxiaojie on 2022/1/13.
//  Copyright © 2022 ChenJie. All rights reserved.
//

#import "AViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviView.hidden = YES;
    self.view.backgroundColor = [UIColor blueColor];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    NSURL *url = [NSURL URLWithString:@""];

    cell.videoItem = [AVPlayerItem playerItemWithURL:url];
    cell.videoPlayer = [AVPlayer playerWithPlayerItem:cell.videoItem];
    cell.avLayer = [AVPlayerLayer playerLayerWithPlayer:cell.videoPlayer];
    cell.videoPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [cell.videoItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [cell.videoItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidBufferPlaying:) name:AVPlayerItemPlaybackStalledNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

    cell.avLayer.frame = CGRectMake(5,9,310,310);
    [cell.contentView.layer addSublayer:cell.avLayer];
    [cell.videoPlayer play];
    [cell.contentView addSubview:cell.videoActivity];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
