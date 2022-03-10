//
//  SecondViewController.m
//  Demo
//
//  Created by ChenJie on 2017/12/12.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import "SecondViewController.h"
#import "TXCategoryKit.h"
#import "TXCommonKit.h"
#import "TXTestViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"笨笨编程";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, 115, 80)];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    //[btn setupWithFont:[UIFont systemFontOfSize:14]];
    [btn setImage:[UIImage imageNamed:@"test.jpeg"] forState:UIControlStateNormal];
    [btn setTitle:@"租车" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)nextVC {
    TXTestViewController *vc = [[TXTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
//    if (indexPath.row == 0) {
//        cell.backgroundColor = [UIColor colorWithHexString:@"FFF000FF"];
//    } else if (indexPath.row == 1) {
//        cell.backgroundColor = [UIColor colorWithHexString:@"FFF000E0"];
//    } else if (indexPath.row == 2) {
//        cell.backgroundColor = [UIColor colorWithHexString:@"FFF000C2"];
//    } else if (indexPath.row == 3) {
//        cell.backgroundColor = [UIColor colorWithHexString:@"FFF00040"];
//    } else if (indexPath.row == 4) {
//        cell.backgroundColor = [UIColor colorWithHexString:@"FFF00000"];
//    } else if (indexPath.row == 5) {
//        cell.backgroundColor = [UIColor colorWithHexString:@"FFF000"];
//    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *str=  [TXAppSystemInfo getDeviceUniqueId];
    NSString *bundleid = AppBundleIdentifier;
    [TXAppSystemInfo getDeviceUniqueId];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
