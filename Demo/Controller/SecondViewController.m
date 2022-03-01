//
//  SecondViewController.m
//  Demo
//
//  Created by ChenJie on 2017/12/12.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import "SecondViewController.h"
#import "AFNetworking.h"
#import "DemoTableViewCell.h"

#import "ATCollectionViewDemoVC.h"
#import "HorizontalCollectionViewController.h"
#import "AtzucheHomeTitleViewController.h"
#import "CellAddCollectionViewController.h"
#import "MJIphoneXViewController.h"
#import "PhoneFontViewController.h"
#import "WKWebViewController.h"
#import "TableViewDeleteViewController.h"


@interface SecondViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *dataAry;
@end

@implementation SecondViewController

#pragma mark - 懒加载
- (NSArray *)dataAry {
    if (_dataAry == nil) {
        _dataAry = @[@"网络请求", @"CollectionView", @"横向 CollectionView", @"自动居中 CollectionView", @"cell add collectionview", @"MJ 下拉刷新兼容 iPhone X", @"iPhone 字体", @"wkwebview", @"自定义左侧滑二次确认删除"];
    }
    return _dataAry;
}

- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"笨笨编程";
    
    [self.view addSubview:self.tableview];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"DemoTableViewCell";
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DemoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [_dataAry objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self httpRequestWithGET];
    } else if (indexPath.row == 1) {
        ATCollectionViewDemoVC *collectionVC = [[ATCollectionViewDemoVC alloc] init];
        [self.navigationController pushViewController:collectionVC animated:YES];
    } else if (indexPath.row == 2) {
        HorizontalCollectionViewController *horizontalVC = [[HorizontalCollectionViewController alloc] init];
        [self.navigationController pushViewController:horizontalVC animated:YES];
    } else if (indexPath.row == 3) {
        AtzucheHomeTitleViewController *titleVC = [[AtzucheHomeTitleViewController alloc] init];
        [self.navigationController pushViewController:titleVC animated:YES];
    } else if (indexPath.row == 4) {
        CellAddCollectionViewController *cellVC = [[CellAddCollectionViewController alloc] init];
        [self.navigationController pushViewController:cellVC animated:YES];
    } else if (indexPath.row == 5) {
        MJIphoneXViewController *mjIphoneXvc = [[MJIphoneXViewController alloc] init];
        [self.navigationController pushViewController:mjIphoneXvc animated:YES];
    } else if (indexPath.row == 6) {
        PhoneFontViewController *fontVC = [[PhoneFontViewController alloc] init];
        [self.navigationController pushViewController:fontVC animated:YES];
    } else if (indexPath.row == 7) {
        WKWebViewController *webview = [[WKWebViewController alloc] init];
        [self.navigationController pushViewController:webview animated:YES];
    } else if (indexPath.row == 8) {
        TableViewDeleteViewController *deleteVC = [[TableViewDeleteViewController alloc] init];
        [self.navigationController pushViewController:deleteVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - indexpath.row == 0
- (void)httpRequestWithGET {
    NSString *url = @"http://v.juhe.cn/toutiao/index";
    NSDictionary *params = @{@"type":@"top",//类型,,top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
                             @"key":@"ad2908cae6020addf38ffdb5e2255c06"//应用APPKEY
                             };
    AFHTTPSessionManager *manager = [self getManager];
    
    //NSLog(@"<-- newRequest -- %@ url --> %@  params --> %@", requestName, url, mutaDict.mj_JSONString);
    
    /** 没有做缓存处理，需要添加缓存处理 */
    [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error);
    }];
}

- (AFHTTPSessionManager *)getManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json", nil];
    
    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession * _Nonnull session, NSURLAuthenticationChallenge * _Nonnull challenge, NSURLCredential *__autoreleasing  _Nullable * _Nullable credential)
     {
         return NSURLSessionAuthChallengePerformDefaultHandling;
     }];
    
    return manager;
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
