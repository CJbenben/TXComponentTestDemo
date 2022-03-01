//
//  PlayerBannerModel.h
//  Demo
//
//  Created by chenxiaojie on 2019/11/22.
//  Copyright © 2019 ChenJie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerBannerModel : NSObject

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSURL *videoUrl;

@end

NS_ASSUME_NONNULL_END
