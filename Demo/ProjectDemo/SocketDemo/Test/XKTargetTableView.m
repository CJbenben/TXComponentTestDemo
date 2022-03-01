//
//  XKTargetTableView.m
//  Demo
//
//  Created by chenxiaojie on 2020/8/12.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import "XKTargetTableView.h"

@interface XKTargetTableView ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign) CGFloat currOffsetY;
@end

@implementation XKTargetTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [UIView new];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return self;
}

//是否支持多时候触发，这里返回YES
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark ========== tableView 代理 ==========
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

#pragma mark ========== scrollview 代理 ==========
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _currOffsetY = scrollView.contentOffset.y;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.canSlide) {
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y == 0 ? 0 : _currOffsetY);
    }
    _currOffsetY = scrollView.contentOffset.y;
    if (scrollView.contentOffset.y < 0 ) {
        self.canSlide = NO;
        scrollView.contentOffset = CGPointZero;
        //到顶通知父视图改变状态
        if (self.slideDragBlock) {
            self.slideDragBlock();
        }
    }
    scrollView.showsVerticalScrollIndicator = self.canSlide ? YES : NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
