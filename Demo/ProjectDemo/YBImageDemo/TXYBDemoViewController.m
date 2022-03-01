//
//  TXYBDemoViewController.m
//  Demo
//
//  Created by chenxiaojie on 2020/4/21.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import "TXYBDemoViewController.h"
#import "TXYBView.h"

@interface TXYBDemoViewController ()

@property (nonatomic, strong) TXYBView *testView;

@end

@implementation TXYBDemoViewController

- (TXYBView *)testView {
    if (_testView == nil) {
        _testView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TXYBView class]) owner:nil options:nil] firstObject];
        _testView.backgroundColor = [UIColor whiteColor];
    }
    return _testView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.testView.frame = CGRectMake(0, naviHeight, SCREEN_WIDTH, SCREEN_HEIGHT - naviHeight);
    [self.view addSubview:self.testView];
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
