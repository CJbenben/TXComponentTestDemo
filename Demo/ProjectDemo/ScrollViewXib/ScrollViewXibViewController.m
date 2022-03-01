//
//  ScrollViewXibViewController.m
//  Demo
//
//  Created by chenxiaojie on 2019/11/12.
//  Copyright © 2019 ChenJie. All rights reserved.
//

#import "ScrollViewXibViewController.h"
#import "ScrollViewTest.h"

@interface ScrollViewXibViewController ()

@property (nonatomic, strong) ScrollViewTest *scrollBgView;

@end

@implementation ScrollViewXibViewController

- (ScrollViewTest *)scrollBgView {
    if (_scrollBgView == nil) {
        _scrollBgView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ScrollViewTest class]) owner:nil options:nil] firstObject];
    }
    return _scrollBgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollBgView];
    self.scrollBgView.frame = CGRectMake(0, naviHeight, SCREEN_WIDTH, SCREEN_HEIGHT-naviHeight);
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
