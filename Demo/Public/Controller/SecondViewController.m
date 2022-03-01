//
//  SecondViewController.m
//  Demo
//
//  Created by ChenJie on 2017/12/12.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import "SecondViewController.h"
#import "DemoTableViewCell.h"

#import "TXCollectionController.h"
#import "MJIphoneXViewController.h"
#import "PhoneFontViewController.h"
#import "HMWebViewController.h"
#import "MVVMViewController.h"
#import "ScrollViewXibViewController.h"
#import "PlayerDemoViewController.h"
#import "TXCollectionViewController.h"

@interface SecondViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *dataAry;
@end

@implementation SecondViewController

static NSString *kJumpTitle     = @"kJumpTitle";
static NSString *kJumpClass     = @"kJumpClass";

#pragma mark - 懒加载
- (NSArray *)dataAry {
    if (_dataAry == nil) {
        _dataAry = @[@{kJumpClass: @"", kJumpTitle: @"网络请求"},
                     @{kJumpClass: @"TXCollectionController", kJumpTitle: @"TXCollectionViewDemo"},
                     @{kJumpClass: @"MJIphoneXViewController", kJumpTitle: @"MJ 下拉刷新兼容 iPhone X"},
                     @{kJumpClass: @"PhoneFontViewController", kJumpTitle: @"iPhone 字体"},
                     @{kJumpClass: @"WKWebViewController", kJumpTitle: @"wkwebview"},
                     @{kJumpClass: @"MVVMViewController", kJumpTitle: @"MVVM"},
                     @{kJumpClass: @"ScrollViewXibViewController", kJumpTitle: @"scrollview xib"},
                     @{kJumpClass: @"PlayerDemoViewController", kJumpTitle: @"ZFPlayerDemo"},
                     @{kJumpClass: @"TXCollectionViewController", kJumpTitle: @"瀑布流&&自适应"},
                     @{kJumpClass: @"SocketViewController", kJumpTitle: @"socket学习"},
                     @{kJumpClass: @"TXYBDemoViewController", kJumpTitle: @"YBImageBrowser 学习"},
                     @{kJumpClass: @"RealmViewController", kJumpTitle: @"Realm 数据库学习"},
                     @{kJumpClass: @"PrinterDemoViewController", kJumpTitle: @"iOS 链接打印机"},
                     @{kJumpClass: @"HMPageScrollTestViewController", kJumpTitle: @"zjpageview"},
                     @{kJumpClass: @"TXPageViewController", kJumpTitle: @"TXPageView"},
                     @{kJumpClass: @"MSViewController", kJumpTitle: @"升级版"},
                     @{kJumpClass:@"TXChildDemoViewController", kJumpTitle: @"ChildVCDemo"},
                     @{kJumpClass: @"SpeechDemoViewController", kJumpTitle: @"语音转文字"}
        ];
    }
    return _dataAry;
}

- (UITableView *)tableview {
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, SCREEN_HEIGHT-naviHeight) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitleL.text = @"笨笨编程";
    self.backImage = nil;
    
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
    NSDictionary *dict = safeObjectTxAtIndex(self.dataAry, indexPath.row);
    cell.textLabel.text = EncodeStringFromDic(dict, kJumpTitle);
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self httpRequestWithGET];
        return;
    }
    NSDictionary *dict = safeObjectTxAtIndex(self.dataAry, indexPath.row);
    NSString *className = EncodeStringFromDic(dict, kJumpClass);
    if (className.length) {
        if ([className isEqualToString:@"HMWebViewController"]) {
            HMWebViewController *webview = [[HMWebViewController alloc] init];
            [webview loadWebURLString:@"https://www.tebimktg.com/mobile/" naviTitle:@"title"];
            [self.navigationController  pushViewController:webview animated:YES];
            return;
        }
        Class class = NSClassFromString(className);
        id vc = [[class alloc] init];
        for (NSString *key in dict.allKeys) {
            @try {
                [vc setValue:[dict objectForKey:key] forKey:key];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
        }
        if (vc) {
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - indexpath.row == 0
- (void)httpRequestWithGET {
    NSString *url = @"http://v.juhe.cn/toutiao/index";
    url = @"http://172.16.0.94:8588/api/v1/app/floor/floor";
    NSDictionary *params = @{@"type":@"top",//类型,,top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
                             @"key":@"ad2908cae6020addf38ffdb5e2255c06"//应用APPKEY
                             };
    
    NSLog(@"url = %@", url);
    
    [CJHTTPRequest httpRequestWithGETWithUrl:url params:params success:^(id result) {
        
        NSLog(@"responseObject = %@", result);

    } failure:^(NSError *error) {
        
        NSLog(@"error = %@", error);

    }];
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
