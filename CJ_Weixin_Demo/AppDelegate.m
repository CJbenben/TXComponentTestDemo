//
//  AppDelegate.m
//  CJ_Weixin_Demo
//
//  Created by ChenJie on 16/6/21.
//  Copyright © 2016年 ChenJie. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "WXApiObject.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate
#pragma mark -
#pragma mark - 微信授权回调
/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void)onReq:(BaseReq*)req{
    NSLog(@"onReq");
}



/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
- (void)onResp:(BaseResp*)resp{
    if([resp isKindOfClass:[SendMessageToWXResp class]]){//微信分享回调
        SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
        if (messageResp.errCode == -2) {
            NSLog(@"用户取消分享");
        }
    }else if ([resp isKindOfClass:[SendAuthResp class]]){//微信登录回调
        SendAuthResp *aresp = (SendAuthResp *)resp;
        
        /*
         ErrCode ERR_OK = 0(用户同意)
         ERR_AUTH_DENIED = -4（用户拒绝授权）
         ERR_USER_CANCEL = -2（用户取消）
         code    用户换取access_token的code，仅在ErrCode为0时有效
         state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
         lang    微信客户端当前语言
         country 微信用户当前国家信息
         */
        
        NSLog(@"aresp.errCode:%d",aresp.errCode);
        
        if (aresp.errCode== 0) {
            NSLog(@"微信登录成功");
        }else if (aresp.errCode == -2){
            NSLog(@"用户取消登录");
        }
    }else if ([resp isKindOfClass:[PayResp class]]){//微信支付
        PayResp *response = (PayResp *)resp;
        NSLog(@"response.returnKey:%@",response.returnKey);
        
        if (response.errCode == WXSuccess) {
            //服务器端查询支付通知或查询API返回的结果再提示成功
            NSLog(@"微信支付成功");
        }else if (response.errCode == WXErrCodeUserCancel){
            NSLog(@"用户取消支付");
        }else{//WXErrCodeCommon
            NSLog(@"支付失败，retcode=%d",response.errCode);
        }
    }
}

//iOS9.0之后回调API接口
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [WXApi handleOpenURL:url delegate:self];
}

//iOS9.0之前回调API接口
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp:kWXAPP_ID withDescription:@"weixin"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
