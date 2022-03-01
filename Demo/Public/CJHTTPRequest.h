//
//  CJHTTPRequest.h
//  Demo
//
//  Created by ChenJie on 2018/9/27.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessDictBlock)(id result);
typedef void (^FailureDictBlock)(NSError *error);

@interface CJHTTPRequest : NSObject

+ (void)httpRequestWithGETWithUrl:(NSString *)url params:(NSDictionary *)params success:(SuccessDictBlock)successBlock failure:(FailureDictBlock)failureBlock;

@end
