//
//  MVVMItemModel.h
//  Demo
//
//  Created by chenxiaojie on 2018/11/23.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVVMItemModel : NSObject

@property (strong, nonatomic) NSString *author_name;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *title;

@end

NS_ASSUME_NONNULL_END
