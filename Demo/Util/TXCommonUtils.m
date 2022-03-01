//
//  TXCommonUtils.m
//  LYHM
//
//  Created by chenxiaojie on 2019/8/23.
//  Copyright © 2019 chenxiaojie. All rights reserved.
//

#import "TXCommonUtils.h"
//#import <AdSupport/AdSupport.h>
//#import "KeychainItemWrapper.h"
//#import "TXFileUtils.h"
//#import "CommonCrypto/CommonDigest.h"
//#import "AppDelegate.h"

@implementation TXCommonUtils

+ (NSString *)htmlEntityDecode:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    return string;
}


@end
