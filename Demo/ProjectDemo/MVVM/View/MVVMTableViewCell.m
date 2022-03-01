//
//  MVVMTableViewCell.m
//  Demo
//
//  Created by chenxiaojie on 2018/11/23.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "MVVMTableViewCell.h"

@interface MVVMTableViewCell ()

@property (strong, nonatomic) UILabel *titleL;

@end
@implementation MVVMTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 40)];
        self.titleL.backgroundColor = [UIColor lightGrayColor];
        self.titleL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleL];
        
    }
    return self;
}

- (void)setItemModel:(MVVMItemModel *)itemModel {
    _itemModel = itemModel;
    self.titleL.text = itemModel.title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
