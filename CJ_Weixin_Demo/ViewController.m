//
//  ViewController.m
//  CJ_Weixin_Demo
//
//  Created by ChenJie on 16/6/21.
//  Copyright © 2016年 ChenJie. All rights reserved.
//

#import "ViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"


#define kWX_PARTNERID @"1234567890"

@interface ViewController ()
- (IBAction)sureOrder;
- (IBAction)surePay;

- (IBAction)shareFriend;
- (IBAction)shareFriends;
- (IBAction)collection;

- (IBAction)shareWithWX:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sureOrder {
    //用户选择商品后，在这里向后台服务器发送下单请求，服务器将生成订单信息等微信所下发的预支付id、签名等信息。然后发起支付调用surePay方法
}

//生成prepayid、签名sign后调用微信SDK发起支付
- (IBAction)surePay {
    //需要创建这个支付对象
    PayReq *req = [[PayReq alloc] init];
    //应用id
    req.openID = kWXAPP_ID;
    
    // 商家商户号
    req.partnerId = kWX_PARTNERID;
    
    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
    req.prepayId = @"";//self.orderWithWX.prepayid;
    
    // 根据财付通文档填写的数据和签名
    //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
    req.package = @"Sign=WXPay";
    
    // 随机编码，为了防止重复的，在后台生成
    req.nonceStr = @"";//self.orderWithWX.noncestr;
    
    // 这个是时间戳，也是在后台生成的，为了验证支付的
    NSString * stamp = @"";//self.orderWithWX.timestamp;
    req.timeStamp = stamp.intValue;
    
    // 这个签名也是后台做的
    req.sign = @"";//self.orderWithWX.sign;
    
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:req];
}

- (IBAction)shareWithWX:(UIButton *)sender {
    //1.分享文字
    //    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    //    req.text = @"笨笨编程";
    //    req.bText = YES;
    
    //2.分享图片
    //    WXMediaMessage *message = [WXMediaMessage message];
    //    [message setThumbImage:[UIImage imageNamed:@"笨笨编程.png"]];
    //        //缩略图
    //    WXImageObject *imageObject = [WXImageObject object];
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"笨笨编程" ofType:@"jpg"];
    //    imageObject.imageData = [NSData dataWithContentsOfFile:filePath];
    //    message.mediaObject = imageObject;
    //
    //    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    //    req.bText = NO;
    //    req.message = message;
    
    //3.分享音乐
    //4.分享视频
    
    
    //5.分享网页
    WXMediaMessage *message2 = [WXMediaMessage message];
    message2.title = @"笨笨编程";
    message2.description = @"描述";
    [message2 setThumbImage:[UIImage imageNamed:@"笨笨编程.png"]];
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = @"http://weibo.com/2728581591/profile?rightmod=1&wvr=6&mod=personnumber";
    message2.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message2;
    
    
    if (sender.tag == 0) {
        req.scene = WXSceneSession;
    }else if (sender.tag == 1){
        req.scene = WXSceneTimeline;
    }else{
        req.scene = WXSceneFavorite;
    }
    [WXApi sendReq:req];
}


@end
