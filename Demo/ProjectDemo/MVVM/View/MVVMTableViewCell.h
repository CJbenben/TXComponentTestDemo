//
//  MVVMTableViewCell.h
//  Demo
//
//  Created by chenxiaojie on 2018/11/23.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVVMItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVVMTableViewCell : UITableViewCell

@property (strong, nonatomic) MVVMItemModel *itemModel;

@end

NS_ASSUME_NONNULL_END
