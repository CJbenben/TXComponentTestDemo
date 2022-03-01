//
//  MVVMBaseViewModel.h
//  Demo
//
//  Created by chenxiaojie on 2019/8/2.
//  Copyright © 2019 ChenJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVVMBaseViewModel : NSObject

- (instancetype)initWithSucc:(SuccessDictBlock)succ fail:(FailureDictBlock)fail;

@end

NS_ASSUME_NONNULL_END
