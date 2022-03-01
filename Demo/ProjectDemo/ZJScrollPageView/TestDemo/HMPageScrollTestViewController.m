//
//  HMPageScrollTestViewController.m
//  Demo
//
//  Created by chenxiaojie on 2020/12/17.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import "HMPageScrollTestViewController.h"
#import "ZJScrollPageView.h"
#import "ZJPageTableViewController.h"

static CGFloat const headViewHeight = 200.0;


@interface ZJCustomGestureTableView : UITableView

@end

@implementation ZJCustomGestureTableView

/// 返回YES同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}
@end

@interface HMPageScrollTestViewController ()<ZJScrollPageViewDelegate, ZJPageViewControllerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ZJScrollSegmentView *segmentView;
/** 横向标题 title 数组 */
@property (strong, nonatomic) NSMutableArray<NSString *> *titles;
/** 横向副标题 detail 数组 */
@property (strong, nonatomic) NSMutableArray<NSString *> *details;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) ZJContentView *contentView;
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) UIScrollView *childScrollView;
@property (strong, nonatomic) ZJCustomGestureTableView *tableView;

@end

static NSString * const cellID = @"cellID";

@implementation HMPageScrollTestViewController

- (ZJScrollSegmentView *)segmentView {
    if (_segmentView == nil) {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.showCover = YES;
        // 遮盖背景颜色
        style.coverBackgroundColor = [UIColor yellowColor];
        style.coverPosition = CoverShowPositionBottom;
        style.coverHeight = 20;
        style.coverCornerRadius = 10;
        // 渐变
        style.gradualChangeTitleColor = YES;
        //标题一般状态颜色 --- 注意一定要使用RGB空间的颜色值
//        style.normalTitleColor = CJRGBCOLOR(0, 0, 0);//CJRGBCOLOR(rValue, gValue, bValue);
        //标题选中状态颜色 --- 注意一定要使用RGB空间的颜色值
//        style.selectedTitleColor = CJRGBCOLOR(0, 0, 0);
        style.scrollTitle = NO;
        style.titleBigScale = 1.0;
        
        CGFloat height = 80;
//        __weak typeof(self) weakSelf = self;
        _segmentView = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, height) bgViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) segmentStyle:style delegate:nil titles:self.titles details:self.details titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            
        }];
    }
    return _segmentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titles = [NSMutableArray array];
    self.details = [NSMutableArray array];
    for (NSInteger i = 0; i<3; i++) {
        [self.titles addObject:[NSString stringWithFormat:@"商品推荐%ld", i]];
        [self.details addObject:[NSString stringWithFormat:@"显示%ld", i]];
    }
    self.segmentView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
}

#pragma ZJScrollPageViewDelegate 代理方法
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = [[ZJPageTableViewController alloc] init];
        ZJPageTableViewController *vc = (ZJPageTableViewController *)childVc;
        vc.delegate = self;
    }
    return childVc;
}


#pragma mark- ZJPageViewControllerDelegate
- (void)scrollViewIsScrolling:(UIScrollView *)scrollView {
    _childScrollView = scrollView;
    if (self.tableView.contentOffset.y < headViewHeight) {
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = NO;
    }
    else {
        self.tableView.contentOffset = CGPointMake(0.0f, headViewHeight);
        scrollView.showsVerticalScrollIndicator = YES;
    }
    
}

#pragma mark- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.childScrollView && _childScrollView.contentOffset.y > 0) {
        self.tableView.contentOffset = CGPointMake(0.0f, headViewHeight);
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < headViewHeight) {
        //[[NSNotificationCenter defaultCenter] postNotificationName:ZJParentTableViewDidLeaveFromTopNotification object:nil];

    }
}

#pragma mark- UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:self.contentView];
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.segmentView;
}

#pragma mark- setter getter
- (ZJContentView *)contentView {
    if (_contentView == nil) {
        ZJContentView *content = [[ZJContentView alloc] initWithFrame:self.view.bounds segmentView:self.segmentView parentViewController:self delegate:self];
        _contentView = content;
    }
    return _contentView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, headViewHeight)];
        UILabel *label = [[UILabel alloc] initWithFrame:_headView.bounds];
        label.text = @"这是header~~~~~~~~~~~~~~";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor redColor];
        [_headView addSubview:label];
        _headView.backgroundColor = [UIColor greenColor];
    }
    
    return _headView;
}

- (ZJCustomGestureTableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0.0f, naviHeight, self.view.bounds.size.width, self.view.bounds.size.height);
        ZJCustomGestureTableView *tableView = [[ZJCustomGestureTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        // 设置tableView的headView
        tableView.tableHeaderView = self.headView;
        tableView.tableFooterView = [UIView new];
        // 设置cell行高为contentView的高度
        tableView.rowHeight = self.contentView.bounds.size.height;
        tableView.delegate = self;
        tableView.dataSource = self;
        // 设置tableView的sectionHeadHeight为segmentViewHeight
        tableView.sectionHeaderHeight = 180;
        tableView.showsVerticalScrollIndicator = false;
        _tableView = tableView;
    }
    
    return _tableView;
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
