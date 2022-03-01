//
//  CJHTTPRequest.m
//  Demo
//
//  Created by ChenJie on 2018/9/27.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "CJHTTPRequest.h"
#import "AFNetworking.h"

@implementation CJHTTPRequest

+ (AFHTTPSessionManager *)getManager {
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

+ (void)httpRequestWithGETWithUrl:(NSString *)url params:(NSDictionary *)params success:(SuccessDictBlock)successBlock failure:(FailureDictBlock)failureBlock {
    
    AFHTTPSessionManager *manager = [self getManager];
    
    //NSLog(@"<-- newRequest -- %@ url --> %@  params --> %@", requestName, url, mutaDict.mj_JSONString);
    
    /** 没有做缓存处理，需要添加缓存处理 */
    [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"responseObject = %@", responseObject);
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //NSLog(@"error = %@", error);
        
        failureBlock(error);
        
    }];
}

@end
