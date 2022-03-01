//
//  HMEnterCollectionViewCell.m
//  LYHM
//
//  Created by chenxiaojie on 2019/8/12.
//  Copyright © 2019 chenxiaojie. All rights reserved.
//

#import "HMHomeLikeCollectionViewCell.h"

@interface HMHomeLikeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *productIV;
/** 产品名称 */
@property (weak, nonatomic) IBOutlet UILabel *productNameL;
/** 现价 */
@property (weak, nonatomic) IBOutlet UILabel *priceL;
/** 分享赚 */
@property (weak, nonatomic) IBOutlet UIButton *shareMoneyBtn;
/** 原价 & 积分 */
@property (weak, nonatomic) IBOutlet UILabel *originPriceAndPVL;
/** 积分 */
//@property (weak, nonatomic) IBOutlet UILabel *pvL;// 废弃
@property (weak, nonatomic) IBOutlet UIImageView *soldoutImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceRightConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *originRightConst;

@end
@implementation HMHomeLikeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.shareMoneyBtn.layer.cornerRadius = 2;
    self.shareMoneyBtn.layer.masksToBounds = YES;
    
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}

//- (void)setShopInfoModel:(HMShopListInfoModel *)shopInfoModel {
//    _soldoutImageView.hidden = shopInfoModel.stockDes.length ? NO : YES;
//    [self.productIV sd_setFadeImageWithURL:[NSURL URLWithString:shopInfoModel.itemImg] placeholderImage:PlaceHolder_Square_Image];
//    self.productNameL.text = shopInfoModel.name;
//    self.priceL.text = RMB(shopInfoModel.memberPrice);
////#ifdef kDevTest
////    shopInfoModel.memberTicket = @"2.88";
////#endif
//    // 没有分享赚字段 或者 分享赚金额为 0 都不展示分享赚
//    if ([shopInfoModel.sharePrice floatValue] == 0 || shopInfoModel.sharePrice.length == 0) {
//        self.priceRightConst.constant = 0;
//        self.priceL.textAlignment = NSTextAlignmentCenter;
//        self.shareMoneyBtn.hidden = YES;
//    } else {
//        self.priceRightConst.constant = self.width/2.0;
//        self.priceL.textAlignment = NSTextAlignmentRight;
//        [self.shareMoneyBtn setTitle:SHARENO(shopInfoModel.sharePrice) forState:UIControlStateNormal];
//        self.shareMoneyBtn.hidden = NO;
//    }
//
//
//    NSMutableAttributedString *originPriceAndPVAttStr = [[NSMutableAttributedString alloc] init];
//    NSAttributedString *originPriceAttStr = [[NSAttributedString alloc] init];
//    if ([shopInfoModel.origprice floatValue]) {
//        originPriceAttStr = [TXCommonUtils formateLabelLineWithSuffixStr:shopInfoModel.priceDesc priceStr:RMB(shopInfoModel.origprice)];
//    }
////    NSAttributedString *pvAttStr = [[NSAttributedString alloc] init];
////    if ([shopInfoModel.pv floatValue]) {
////        pvAttStr = [[NSAttributedString alloc] initWithString:PV(shopInfoModel.pv)];
////    }
//
//    [originPriceAndPVAttStr appendAttributedString:originPriceAttStr];
//    [originPriceAndPVAttStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"  "]];
////    [originPriceAndPVAttStr appendAttributedString:pvAttStr];
//
//    [originPriceAndPVAttStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"]}
//                                    range:NSMakeRange(0, originPriceAttStr.length)];
//
//    self.originPriceAndPVL.attributedText = originPriceAndPVAttStr;
////    CGFloat shareMoneyLW = [self.shareMoneyL.text sizeWithFont:self.shareMoneyL.font maxSize:CGSizeMake(300, self.shareMoneyL.height)].width;
////    self.shareMoneyL.width = shareMoneyLW + 10;
//}



@end
