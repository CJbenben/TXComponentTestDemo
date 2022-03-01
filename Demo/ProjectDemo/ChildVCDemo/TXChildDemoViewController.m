//
//  TXChildDemoViewController.m
//  Demo
//
//  Created by chenxiaojie on 2022/1/13.
//  Copyright © 2022 ChenJie. All rights reserved.
//

#import "TXChildDemoViewController.h"
#import "AViewController.h"
#import "BViewController.h"

@interface TXChildDemoViewController ()
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;

@property (strong, nonatomic) AViewController *leftVC;
@property (strong, nonatomic) BViewController *rightVC;
@property (strong, nonatomic) UIViewController *currVC;
@end

@implementation TXChildDemoViewController

- (UIButton *)leftBtn {
    if (_leftBtn == nil) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, naviHeight, SCREEN_WIDTH_HALF, 40);
        _leftBtn.tag = 1;
        _leftBtn.backgroundColor = [UIColor greenColor];
        [_leftBtn setTitle:@"A" forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (_rightBtn == nil) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(SCREEN_WIDTH_HALF, naviHeight, SCREEN_WIDTH_HALF, 40);
        _rightBtn.backgroundColor = [UIColor lightGrayColor];
        [_rightBtn setTitle:@"B" forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.rightBtn];
    
    [self btnBeginState];
    
    [self addSubControllers];
}

- (void)addSubControllers{
    _leftVC = [[AViewController alloc] initWithNibName:@"AViewController" bundle:nil];
    [self addChildViewController:_leftVC];
    _rightVC = [[BViewController alloc] initWithNibName:@"BViewController" bundle:nil];
    [self addChildViewController:_rightVC];
    [self fitFrameForChildViewController:_leftVC];
    [self.view addSubview:_leftVC.view];
    
    _currVC = _leftVC;
    
}

- (void)fitFrameForChildViewController:(UIViewController *)chileViewController{
    CGRect frame = self.view.frame;
    frame.origin.y = CGRectGetMaxY(self.leftBtn.frame);
    chileViewController.view.frame = frame;
}

//转换子视图控制器
- (void)transitionFromOldViewController:(UIViewController *)oldViewController toNewViewController:(UIViewController *)newViewController {
    //NSLog(@"oldViewController=%@, newViewController=%@", oldViewController, newViewController);
    WS(weakSelf)
    [self transitionFromViewController:oldViewController toViewController:newViewController duration:1 options:0 animations:^{
        
    } completion:^(BOOL finished) {
        if (finished) {
            [newViewController didMoveToParentViewController:weakSelf];
            [weakSelf.view addSubview:newViewController.view];
            weakSelf.currVC = newViewController;
        } else{
            [weakSelf.view addSubview:oldViewController.view];
            weakSelf.currVC = oldViewController;
        }
    }];
}

//移除所有子视图控制器
- (void)removeAllChildViewControllers{
    for (UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
}

- (void)btnAction:(UIButton *)sender {
    // 奖励提现申请
    if (sender.tag == 1) {
        [self btnBeginState];
        
        [self fitFrameForChildViewController:_leftVC];
        [self transitionFromOldViewController:_currVC toNewViewController:_leftVC];
        
    } else { // 提现记录
        [self modifyBtnNormalState:self.leftBtn];
        [self modifyBtnSelectState:self.rightBtn];
        
        [self fitFrameForChildViewController:_rightVC];
        [self transitionFromOldViewController:_currVC toNewViewController:_rightVC];
    }
}

- (void)btnBeginState {
    [self modifyBtnSelectState:self.leftBtn];
    [self modifyBtnNormalState:self.rightBtn];
}

- (void)modifyBtnNormalState:(UIButton *)btn {
    [btn setBackgroundColor:[UIColor lightGrayColor]];
}
- (void)modifyBtnSelectState:(UIButton *)btn {
    [btn setBackgroundColor:[UIColor greenColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
