//
//  AtzucheHomeChooseCarCollectionCell.h
//  Demo
//
//  Created by ChenJie on 2018/1/29.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AtzucheHomeChooseCarCollectionCell : UICollectionViewCell
/** 车辆照片 */
@property (nonatomic, strong) UIImageView *carImageV;
/** 车辆配置 */
@property (nonatomic, strong) UILabel *carConfigL;
/** 车牌 */
@property (nonatomic, strong) UILabel *carCardL;
/** 车辆备注 */
@property (nonatomic, strong) UILabel *carRemarkL;
/** 车辆价格 */
@property (nonatomic, strong) UILabel *carPriceL;

@end
