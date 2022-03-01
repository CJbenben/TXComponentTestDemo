//
//  ClickActionViewController.m
//  Demo
//
//  Created by chenxiaojie on 2021/5/26.
//  Copyright © 2021 ChenJie. All rights reserved.
//

#import "ClickActionViewController.h"

@interface ClickActionViewController ()

@end

@interface TouchView : UIView

@end

@implementation ClickActionViewController


//在网络请求前插入这个方法，再根据需求做相应的防范
- (BOOL)getDelegateStatus
{
    NSDictionary *proxySettings = CFBridgingRelease((__bridge CFTypeRef _Nullable)((__bridge NSDictionary *)CFNetworkCopySystemProxySettings()));
    NSArray *proxies = CFBridgingRelease((__bridge CFTypeRef _Nullable)((__bridge NSArray *)CFNetworkCopyProxiesForURL((__bridge CFURLRef)[NSURL URLWithString:@"http://www.google.com"], (__bridge CFDictionaryRef)proxySettings)));
    NSDictionary *settings = [proxies objectAtIndex:0];
    NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
    {
        //没有设置代理
        return NO;
        
    } else {
        //设置代理了
        return YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addViews];
    
    NSLog(@"是否连接了代理 = %d", [self getDelegateStatus]);
}

- (void)addViews {
    TouchView *blueView = [[TouchView alloc] initWithFrame:CGRectMake(0, naviHeight, 50, 50)];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.tag = 0;
    [self.view addSubview:blueView];
    
    TouchView *redView = [[TouchView alloc] initWithFrame:CGRectMake(0, naviHeight, 50, 50)];
    redView.backgroundColor = [UIColor redColor];
    redView.alpha = 1;
    redView.tag = 1;
    [self.view addSubview:redView];
    
    
    
    [self addGestureRecognizer];
}

- (void)addGestureRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testAction)];
    [self.view addGestureRecognizer:tap];
}

- (NSString *)URLEncodedString:(NSString *)str {
    NSString *encodeUrl = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return encodeUrl;
}


- (NSString *)URLDecodedString:(NSString *)str
{
   NSString *result = [str stringByReplacingOccurrencesOfString:@"+" withString:@" "];
   return [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (void)testAction {
    NSLog(@"白色");
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

@implementation TouchView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", self.tag == 0 ? @"蓝色" : @"红色");
}

@end
