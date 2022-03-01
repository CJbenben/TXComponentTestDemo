//
//  HMWebViewController.m
//  LYHM
//
//  Created by chenxiaojie on 2019/9/5.
//  Copyright © 2019 chenxiaojie. All rights reserved.
//

#import "HMWebViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>
//#import "HMOrderListViewController.h"
//#import "HMLocationManager.h"
static void *WkwebBrowserContext = &WkwebBrowserContext;

/** webview 加载类型 */
typedef NS_ENUM(NSUInteger, WKWebLoadType) {
    WKWebLoadTypeURLStr = 0,        // 加载 外部 url 链接
    WKWebLoadTypeHTMLStr,           // 加载 html 标签
    WKWebLoadTypeLocalHTML          // 加载本地
};


@interface HMWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

/** 导航栏 close 图片 */
@property (nonatomic, strong) UIImageView *naviCloseIV;
@property (nonatomic, strong) UIButton *naviCloseBtn;

@property (nonatomic, strong) WKWebView *wkWebView;
/** 设置加载进度条 */
@property (nonatomic, strong) UIProgressView *progressView;
/** 保存的网址链接 */
@property (nonatomic, strong) NSString *URLString;
/** 网页加载的类型 */
@property(nonatomic,assign) WKWebLoadType loadType;

@property (nonatomic, strong) NSString *localPath;
/** 保存请求链接 */
@property (nonatomic, strong) NSMutableArray* snapShotsArray;

@property (nonatomic,assign) BOOL needDealloc;
@property (nonatomic, assign) BOOL isHiddenNavi;
@property (nonatomic, assign) BOOL isHiddenStatusBar;
/** 状态栏颜色（1：白色 0：黑色 默认0） */
@property (nonatomic, assign) BOOL statusBarColor;

/** 上次是否登录状态 */
@property (nonatomic, assign) BOOL lastLoginStatus;

//@property (nonatomic, strong) HMLocationManager *locationManager;

@end

@implementation HMWebViewController

- (UIImageView *)naviCloseIV {
    if (_naviCloseIV == nil) {
        UIImage *closeImage = [UIImage imageNamed:@"ic_shopdetail_skuselect_close"];
        _naviCloseIV = [[UIImageView alloc] initWithImage:closeImage];
        CGFloat backIVY = self.naviTitleL.y + (self.naviTitleL.height - closeImage.size.height)/2.0;
        _naviCloseIV.frame = CGRectMake(55, backIVY, closeImage.size.width, closeImage.size.height);
        _naviCloseIV.userInteractionEnabled = YES;
        _naviCloseIV.hidden = YES;
    }
    return _naviCloseIV;
}

- (UIButton *)naviCloseBtn {
    if (_naviCloseBtn == nil) {
        _naviCloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _naviCloseBtn.bounds = CGRectMake(0, 0, 45, 45);
        _naviCloseBtn.center = self.naviCloseIV.center;
        _naviCloseBtn.hidden = YES;
        [_naviCloseBtn addTarget:self action:@selector(naviCloseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviCloseBtn;
}

- (WKWebView *)wkWebView{
    if (_wkWebView == nil) {
        //设置网页的配置文件
        WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
        //允许视频播放
        configuration.allowsAirPlayForMediaPlayback = YES;
        // 允许在线播放
        configuration.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        configuration.selectionGranularity = YES;
        // web内容处理池
        configuration.processPool = [[WKProcessPool alloc] init];
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController * userContentController = [[WKUserContentController alloc]init];
        [userContentController addScriptMessageHandler:self name:@"lotteryFinish"];
        [userContentController addScriptMessageHandler:self name:@"hmJsCallNative"];
        [userContentController addScriptMessageHandler:self name:@"callBack"];
        // 是否支持记忆读取
        configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        configuration.userContentController = userContentController;
        
        CGRect webViewF = CGRectMake(0, 20 + self.iphonexNaviPadding, SCREEN_WIDTH, SCREEN_HEIGHT - 20 - self.iphonexNaviPadding);
        if (self.isHiddenNavi) {
            
        } else {
            webViewF = CGRectMake(0, self.naviView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.naviView.bottom);
        }
        _wkWebView = [[WKWebView alloc] initWithFrame:webViewF configuration:configuration];
        _wkWebView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        // 设置代理
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        //kvo 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
        //开启手势触摸
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        // 设置 可以前进 和 后退
        // 适应你设定的尺寸
        [_wkWebView sizeToFit];
    }
    return _wkWebView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        if (self.isHiddenNavi == YES) {
            _progressView.frame = CGRectMake(0, self.iphonexNaviPadding + 20, self.view.bounds.size.width, 3);
        }else{
            _progressView.frame = CGRectMake(0, naviHeight, self.view.bounds.size.width, 3);
        }
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}

- (NSMutableArray*)snapShotsArray {
    if (!_snapShotsArray) {
        _snapShotsArray = [NSMutableArray array];
    }
    return _snapShotsArray;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
}

- (void)loadWebURLString:(NSString *)urlStr {
    [self loadWebURLString:urlStr naviTitle:@"" isHiddenNavi:NO isHiddenStatusBar:NO statusBarColor:NO];
}

- (void)loadWebURLString:(NSString *)urlStr naviTitle:(nonnull NSString *)naviTitle {
    [self loadWebURLString:urlStr naviTitle:naviTitle isHiddenNavi:NO isHiddenStatusBar:NO statusBarColor:NO];
}

- (void)loadWebURLString:(NSString *)urlStr naviTitle:(NSString *__nullable)naviTitle isHiddenNavi:(BOOL)isHiddenNavi isHiddenStatusBar:(BOOL)isHiddenStatusBar statusBarColor:(BOOL)statusBarColor {
//    NSDictionary *result = [TXCommonUtils parameterWithURLstr:urlStr];
//    // 如果 url 不含 token，登录状态下，前端拼接 token
//    if (![result.allKeys containsObject:@"token"] && [HMUtils isLogin]) {
//        if (result.allKeys.count) {
//            urlStr = [NSString stringWithFormat:@"%@&token=%@", urlStr, [HMMobileApplication sharedInstance].user.token];
//        } else {
//            urlStr = [NSString stringWithFormat:@"%@?token=%@", urlStr, [HMMobileApplication sharedInstance].user.token];
//        }
//    }
    self.URLString = urlStr;
    self.naviTitle = naviTitle;
    self.isHiddenNavi = isHiddenNavi;
    self.isHiddenStatusBar = isHiddenStatusBar;
    self.statusBarColor = statusBarColor;
    
//    if ([result.allValues containsObject:@"isHiddenNavi"]) {
//        self.isHiddenNavi = [EncodeStringFromDic(result, @"isHiddenNavi") boolValue];
//    }
//    if ([result.allValues containsObject:@"isHiddenStatusBar"]) {
//        self.isHiddenStatusBar = [EncodeStringFromDic(result, @"isHiddenStatusBar") boolValue];
//    }
//    if ([result.allValues containsObject:@"statusBarColor"]) {
//        self.statusBarColor = [EncodeStringFromDic(result, @"statusBarColor") boolValue];
//    }
    self.loadType = WKWebLoadTypeURLStr;
}

- (void)loadWebHTMLSring:(NSString *)htmlStr {
//    self.URLString = [TXCommonUtils htmlEntityDecode:htmlStr];
    self.loadType = WKWebLoadTypeHTMLStr;
}

- (void)loadLocalPathURLWithSuffix:(NSString *)suffix {
    self.localPath = [[NSBundle mainBundle] pathForResource:suffix ofType:@"html"];
    self.loadType = WKWebLoadTypeLocalHTML;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.needDealloc = YES;
    // 非登录情况下 viewDidLoad 里面加载，登录情况下 viewWillAppear 处理加载
//    if (![HMUtils isLogin]) {
        //加载web页面
        [self webViewloadURLType];
//    }
    
    [self.naviView addSubview:self.naviCloseIV];
    [self.naviView addSubview:self.naviCloseBtn];
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progressView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.isHiddenNavi) {
        self.naviView.hidden = YES;
        UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
        statusBarView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:statusBarView];
    } else {
        self.naviView.hidden = NO;
    }
//    // 当前状态 ！= 上次状态  刷新 wkwebview
//    if ([HMUtils isLogin] != self.lastLoginStatus) {
//        //加载web页面
//        [self webViewloadURLType];
//    }
//    // 记录上次是否登录记录
//    self.lastLoginStatus = [HMUtils isLogin];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.statusBarColor) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //[self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

- (void)webViewloadURLType {
    if (self.loadType == WKWebLoadTypeURLStr) {
        //创建一个NSURLRequest 的对象
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [self.wkWebView loadRequest:request];
    } else if (self.loadType == WKWebLoadTypeHTMLStr) {
        if (self.URLString.length) {
            [self.wkWebView loadHTMLString:self.URLString baseURL:nil];
        } else {
#ifdef kDevTest
            [self showHUDMessage:@"加载本地 html 字符串为空"];
#endif
        }
    } else if (self.loadType == WKWebLoadTypeLocalHTML) {
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:self.localPath]]];
    }
}

#pragma mark - Action
- (void)backAction {
    if (self.wkWebView.goBack) {
        [self.wkWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)naviCloseBtnAction {
    if (self.wkWebView.goBack) {
        [self.wkWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)updateNavigationItems{
    if (self.wkWebView.canGoBack) {
        self.naviCloseIV.hidden = self.naviCloseBtn.hidden = NO;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.naviCloseIV.hidden = self.naviCloseBtn.hidden = YES;
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (self.naviTitle.length) {
        self.naviTitleL.text = self.naviTitle;
    } else {// 获取加载网页的标题
        self.naviTitleL.text = self.wkWebView.title;
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateNavigationItems];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.progressView.hidden = NO;
}

// 内容返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

// 服务器请求跳转的时候调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 服务器开始请求的时候调用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeFormSubmitted: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeBackForward: {
            break;
        }
        case WKNavigationTypeReload: {
            break;
        }
        case WKNavigationTypeFormResubmitted: {
            break;
        }
        case WKNavigationTypeOther: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        default: {
            break;
        }
    }
    [self updateNavigationItems];
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 请求链接处理
- (void)pushCurrentSnapshotViewWithRequest:(NSURLRequest*)request {
    //    NSLog(@"push with request %@",request);
    NSURLRequest* lastRequest = (NSURLRequest*)[[self.snapShotsArray lastObject] objectForKey:@"request"];
    
    //如果url是很奇怪的就不push
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        //        NSLog(@"about blank!! return");
        return;
    }
    //如果url一样就不进行push
    if ([lastRequest.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
        return;
    }
    UIView* currentSnapShotView = [self.wkWebView snapshotViewAfterScreenUpdates:YES];
    [self.snapShotsArray addObject:
     @{@"request":request,@"snapShotView":currentSnapShotView}];
}

// 内容加载失败时候调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"页面加载超时");
}

// 跳转失败的时候调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

// 进度条
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}

#pragma mark - WKUIDelegate
//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// 获取js 里面的提示
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

// js 信息的交流
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 交互。可输入的文本。
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    
}

#pragma mark - WKScriptMessageHandler
// 拦截执行网页中的JS方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *dict = message.body;
    NSLog(@"jsCallNative = %@", dict);
    
//#ifdef kDevTest
//    [self showHUDMessage:[NSString stringWithFormat:@"%@", message.body]];
//#endif
    
    if ([message.name isEqualToString:@"hmJsCallNative"]) {
//        HMBaseModel *jumpModel = [HMBaseModel mj_objectWithKeyValues:dict];
//        if ([jumpModel.jumpUrl isEqualToString:@"HMLoginViewController"]) {
//            NSString *urlStr = EncodeStringFromDic(dict, @"urlStr");
//            [self pushLoginVCWithSuccess:^{
//                if (urlStr.length) {
//                    NSString *tokenUrl = [NSString stringWithFormat:@"%@?token=%@", urlStr, [HMMobileApplication sharedInstance].user.token];
//                    [self loadWebURLString:tokenUrl naviTitle:@"" isHiddenNavi:self.isHiddenNavi isHiddenStatusBar:self.isHiddenStatusBar statusBarColor:self.statusBarColor];
//                }
//                [self webViewloadURLType];
//            } cancelBlock:^{
//                //[self showHUDMessage:@"用户取消登录"];
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }];
//        } else if ([jumpModel.jumpUrl isEqualToString:@"getLocationInfo"]) {
//            [self getLocationInfo];
//        } else if ([jumpModel.jumpUrl isEqualToString:@"shareWx"]) {
//            NSDictionary *jumpParamDict = [NSString dictionaryWithJSONString:jumpModel.jumpParam];
//            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//            pasteboard.string = EncodeStringFromDic(jumpParamDict, @"url");
//            if (pasteboard.string.length) {
//                [self showHUDMessage:@"文案已复制"];
//            }
//            NSURL * url = [NSURL URLWithString:@"weixin://"];
//            BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
//            if (canOpen) {
//                [[UIApplication sharedApplication] openURL:url];
//            }
//        } else if ([jumpModel.jumpUrl isEqualToString:@"gotoHome"]) {
//            [self gotoHome];
//        } else {
//            [self jumpNextVCWithClassName:jumpModel.jumpUrl param:jumpModel.jumpParam];
//        }
    }
    if ([message.name isEqualToString:@"lotteryFinish"]) {
        [self lotteryFinishAction];
    }
    if ([message.name isEqualToString:@"callBack"]) {
        [self callBackAction];
    }
}

- (void)callBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
//抽奖完成处理
- (void)lotteryFinishAction
{
//    if (self.refreshBlock) {
//        self.refreshBlock();
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
//    HMOrderListViewController *orderListVC = [[HMOrderListViewController alloc] init];
//    orderListVC.statusType = @"0";
//    [self.navigationController pushViewController:orderListVC animated:YES];
//    [HMUtils removeVC:self];
//}
//
//- (void)refreshLocationInfo
//{
//    if (!self.locationManager) {
//        return;
//    }
//    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways ||
//    [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
//        [self getLocationInfo];
//    }else
//    {
//        NSString* jsStr = @"callBackCity('-1')";
//        [self.wkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//            NSLog(@"result=%@  error=%@",result, error);}];
//    }
}

//获取定位
- (void)getLocationInfo
{
//    self.locationManager = [[HMLocationManager alloc] init];
//    WS(weakSelf)
//    [self.locationManager startLoactionWithResut:^(NSString *str) {
//        if (str.length) {
//            NSString* jsStr = [NSString stringWithFormat:@"callBackCity('%@')",str];
//            [weakSelf.wkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//                NSLog(@"result=%@  error=%@",result, error);}];
//        }
//    }];
}

+ (void)clearWebCache {
    /*
     在磁盘缓存上。
     WKWebsiteDataTypeDiskCache,
     html离线Web应用程序缓存。
     WKWebsiteDataTypeOfflineWebApplicationCache,
     内存缓存。
     WKWebsiteDataTypeMemoryCache,
     本地存储。
     WKWebsiteDataTypeLocalStorage,
     Cookies
     WKWebsiteDataTypeCookies,
     会话存储
     WKWebsiteDataTypeSessionStorage,
     IndexedDB数据库。
     WKWebsiteDataTypeIndexedDBDatabases,
     查询数据库。
     WKWebsiteDataTypeWebSQLDatabases
     */
    NSArray * types=@[WKWebsiteDataTypeCookies,
                      WKWebsiteDataTypeLocalStorage,
                      WKWebsiteDataTypeDiskCache,
                      WKWebsiteDataTypeMemoryCache,
                      WKWebsiteDataTypeOfflineWebApplicationCache];
    NSSet *websiteDataTypes= [NSSet setWithArray:types];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
}

- (void)dealloc{
    //191025_chenxiaojie_放置 viewDidDisappear 方法中处理
    //[self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    
    if(self.needDealloc) {
        [[self.wkWebView configuration].userContentController removeScriptMessageHandlerForName:@"hmJsCallNative"];
        [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"lotteryFinish"];
        [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"callBack"];
    }
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
