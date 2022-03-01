//
//  WKWebViewController.m
//  Demo
//
//  Created by ChenJie on 2018/5/7.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "TXCommonUtils.h"

@interface WKWebViewController ()<WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *detailWebView;

@end

@implementation WKWebViewController

- (WKWebView *)detailWebView {
    if (_detailWebView == nil) {
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"hmJsCallNative"];
        // 自适应屏幕宽度js
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        // 添加自适应屏幕宽度js调用的方法
        [userContentController addUserScript:wkUserScript];
        wkWebConfig.userContentController = userContentController;
        
        _detailWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, SCREEN_HEIGHT - naviHeight) configuration:wkWebConfig];
        _detailWebView.navigationDelegate = self;
        _detailWebView.backgroundColor = [UIColor whiteColor];
    }
    return _detailWebView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backImage = [UIImage imageNamed:@"public_navi_left_back"];
    [self.view addSubview:self.detailWebView];
    
    NSString *str = @"";
    [self.detailWebView loadHTMLString:[TXCommonUtils htmlEntityDecode:str] baseURL:nil];
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    NSString *js = @"function addImgClickEvent() { \
    var imgs = document.getElementsByTagName('img'); \
    var json = []; \
    for (var i = 0; i < imgs.length; ++i) { \
    var img = imgs[i]; \
    json.push(img.src); \
    img.onclick = function () { \
    window.webkit.messageHandlers.hmJsCallNative.postMessage({images: JSON.stringify(json), img: this.src}); \
    }; \
    } \
    }";
    // 注入JS代码
    [webView evaluateJavaScript:js completionHandler:nil];
    [webView evaluateJavaScript:@"addImgClickEvent();"  completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@",result);
    }];
}

#pragma mark - WKScriptMessageHandler
// 拦截执行网页中的JS方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *dict = message.body;
    NSLog(@"jsCallNative = %@", dict);
    
    if ([message.name isEqualToString:@"hmJsCallNative"]) {
        NSString *imagesStr = EncodeStringFromDic(dict, @"images");
        NSArray *images = [NSJSONSerialization JSONObjectWithData:[imagesStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        NSLog(@"images = %@", images);
    }
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
