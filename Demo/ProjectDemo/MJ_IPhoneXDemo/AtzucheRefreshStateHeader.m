//
//  AtzucheRefreshStateHeader.m
//  Demo
//
//  Created by ChenJie on 2018/4/16.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "AtzucheRefreshStateHeader.h"

@implementation AtzucheRefreshStateHeader

- (void)prepare
{
    [super prepare];

    // 设置控件的高度
    self.mj_h += IS_IPHONE_X ? 24:0;
    
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.stateLabel.hidden) return;
    
    BOOL noConstrainsOnStatusLabel = self.stateLabel.constraints.count == 0;
    
    CGFloat iphonexPadding = IS_IPHONE_X ? 24:0;
    
    if (self.lastUpdatedTimeLabel.hidden) {
        // 状态
        //if (noConstrainsOnStatusLabel) self.stateLabel.frame = self.bounds;
        
        if (noConstrainsOnStatusLabel) {
            CGRect frame = self.bounds;
            self.stateLabel.frame = CGRectMake(frame.origin.x, frame.origin.y + iphonexPadding, frame.size.width, frame.size.height);
        }
    } else {
        CGFloat stateLabelH = (self.mj_h - iphonexPadding) * 0.5;
        // 状态
        if (noConstrainsOnStatusLabel) {
            self.stateLabel.mj_x = 0;
            self.stateLabel.mj_y = iphonexPadding;
            self.stateLabel.mj_w = self.mj_w;
            self.stateLabel.mj_h = stateLabelH;
        }
        
        // 更新时间
        if (self.lastUpdatedTimeLabel.constraints.count == 0) {
            self.lastUpdatedTimeLabel.mj_x = 0;
            self.lastUpdatedTimeLabel.mj_y = stateLabelH + iphonexPadding;
            self.lastUpdatedTimeLabel.mj_w = self.mj_w;
            self.lastUpdatedTimeLabel.mj_h = self.mj_h - self.lastUpdatedTimeLabel.mj_y;
        }
        /*
         CGFloat stateLabelH = self.mj_h * 0.5;
         // 状态
         if (noConstrainsOnStatusLabel) {
         self.stateLabel.mj_x = 0;
         self.stateLabel.mj_y = 0;
         self.stateLabel.mj_w = self.mj_w;
         self.stateLabel.mj_h = stateLabelH;
         }
         
         // 更新时间
         if (self.lastUpdatedTimeLabel.constraints.count == 0) {
         self.lastUpdatedTimeLabel.mj_x = 0;
         self.lastUpdatedTimeLabel.mj_y = stateLabelH;
         self.lastUpdatedTimeLabel.mj_w = self.mj_w;
         self.lastUpdatedTimeLabel.mj_h = self.mj_h - self.lastUpdatedTimeLabel.mj_y;
         }
         */
    }
}

@end
