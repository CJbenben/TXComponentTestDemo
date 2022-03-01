//
//  MVVMViewModel.m
//  Demo
//
//  Created by chenxiaojie on 2018/11/23.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "MVVMViewModel.h"

@interface MVVMViewModel ()

@property (nonatomic, copy) SuccessDictBlock succ;/**<请求成功*/

@property (nonatomic, copy) FailureDictBlock fail;/**<请求成功*/

@end
@implementation MVVMViewModel

- (instancetype)initWithSucc:(SuccessDictBlock)succ fail:(FailureDictBlock)fail {
    self = [super init];
    if (self) {
        _succ = succ;
        _fail = fail;
        //_datas = [NSMutableArray new];
        //[self addObserver:self forKeyPath:@"selectName" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
    
}

- (void)getHttpDataWithSuccess:(SuccessDictBlock)successBlock failure:(FailureDictBlock)failureBlock {
    
    NSString *url = @"http://v.juhe.cn/toutiao/index";
    NSDictionary *params = @{@"type":@"top",//类型,,top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
                             @"key":@"ad2908cae6020addf38ffdb5e2255c06"//应用APPKEY
                             };
    
    [CJHTTPRequest httpRequestWithGETWithUrl:url params:params success:^(id result) {
        
        //self.baseModel = [MVVMBaseModel mj_objectWithKeyValues:result];
        successBlock(result);
        
    } failure:^(NSError *error) {
        
        failureBlock(error);
        
    }];
}

@end
