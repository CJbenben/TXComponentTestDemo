//
//  MVVMViewModel.h
//  Demo
//
//  Created by chenxiaojie on 2018/11/23.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "MVVMBaseViewModel.h"
#import "MVVMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

/** viewModel 是一个放置用户输入验证逻辑，视图显示逻辑，发起网络请求和其他代码的地方 */
@interface MVVMViewModel : MVVMBaseViewModel

@property (strong, nonatomic) MVVMBaseModel *baseModel;
- (void)getHttpDataWithSuccess:(SuccessDictBlock)successBlock failure:(FailureDictBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
