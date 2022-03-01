//
//  MJIphoneXViewController.m
//  Demo
//
//  Created by ChenJie on 2018/3/30.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "MJIphoneXViewController.h"
#import "MJDIYHeader.h"
#import "AtzucheRefreshStateHeader.h"
#import "AFNetworking.h"

@interface MJIphoneXViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mjTestTableView;
/** 关于 iPhone X 适配距离顶部边距 */
@property (nonatomic, assign) CGFloat iphonexPadding;

@end

@implementation MJIphoneXViewController

- (UITableView *)mjTestTableView {
    if (_mjTestTableView == nil) {
        _mjTestTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, SCREEN_HEIGHT-naviHeight) style:UITableViewStylePlain];
        _mjTestTableView.backgroundColor = [UIColor lightGrayColor];
        _mjTestTableView.dataSource = self;
        _mjTestTableView.delegate = self;
    }
    return _mjTestTableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if (@available(iOS 11.0, *)) {
        self.mjTestTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iphonexPadding = IS_IPHONE_X ? 24 : 0;
    
    self.view.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.mjTestTableView];
    
    
    //[self example06];
    [self example01];
}

- (void)loadNewData {
    [self httpRequestWithGET];
}

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
        
        [self.mjTestTableView.mj_header endRefreshing];
        [self.mjTestTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error);
        
        [self.mjTestTableView.mj_header endRefreshing];
    }];
}

#pragma mark UITableView + 下拉刷新 自定义刷新控件
- (void)example06
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.mjTestTableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.mjTestTableView.mj_header beginRefreshing];
}

- (void)example01 {
    AtzucheRefreshStateHeader *header = [AtzucheRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mjTestTableView.mj_header = header;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
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
