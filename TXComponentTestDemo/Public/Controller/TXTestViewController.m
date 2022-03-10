//
//  TXTestViewController.m
//  Demo
//
//  Created by chenxiaojie on 2022/3/10.
//  Copyright © 2022 ChenJie. All rights reserved.
//

#import "TXTestViewController.h"

@interface TXTestViewController ()

@end

@implementation TXTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitleL.text = @"nextVC";
    self.rightBtnTitle = @"编辑";
    self.rightBtnImage = @"ic_store_close_black";
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
