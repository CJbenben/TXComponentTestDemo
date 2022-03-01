//
//  MVVMBaseModel.h
//  Demo
//
//  Created by chenxiaojie on 2018/11/23.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVVMModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVVMBaseModel : NSObject

@property (strong, nonatomic) NSString *error_code;
@property (strong, nonatomic) NSString *reason;
@property (strong, nonatomic) MVVMModel *result;

@end

NS_ASSUME_NONNULL_END
