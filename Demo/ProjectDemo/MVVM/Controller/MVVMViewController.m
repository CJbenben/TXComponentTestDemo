//
//  MVVMViewController.m
//  Demo
//
//  Created by chenxiaojie on 2018/11/23.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "MVVMViewController.h"
#import "MVVMViewModel.h"
#import "MVVMView.h"
#import "MJExtension.h"
#import "MVVMTableViewCell.h"
#import "ReactiveObjC.h"

@interface MVVMViewController ()<MVVMViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) MVVMView *mvvmView;
@property (strong, nonatomic) MVVMViewModel *viewModel;

@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mvvmView = [[MVVMView alloc] initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, SCREEN_HEIGHT-naviHeight)];
    [self.view addSubview:self.mvvmView];
    self.mvvmView.delegate = self;
    
    self.mvvmView.tableview.dataSource = self;
    self.mvvmView.tableview.delegate = self;
    
    
    [[self.mvvmView.tableview rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"x = %@", x);
    }];
}

- (void)mvvmViewBtnAction {
    self.viewModel = [[MVVMViewModel alloc] init];
    
    [self.viewModel getHttpDataWithSuccess:^(id result) {
        
        NSLog(@"responseObject = %@", result);
        
        self.viewModel.baseModel = [MVVMBaseModel mj_objectWithKeyValues:result];
        [self.mvvmView.tableview reloadData];
        
        NSLog(@"responseObject = %@", result);
        
    } failure:^(NSError *error) {
        
        NSLog(@"error = %@", error);
    
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.baseModel.result.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MVVMTableViewCell";
    MVVMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MVVMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.itemModel = [self.viewModel.baseModel.result.data objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
