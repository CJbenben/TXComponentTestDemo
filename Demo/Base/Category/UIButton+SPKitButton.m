//
//  UIButton+SPKitButton.m
//  ShopMobile
//
//  Created by greenleaf on 2018/10/15.
//  Copyright © 2018年 soubao. All rights reserved.
//

#import "UIButton+SPKitButton.h"
#import "Aspects.h"
@implementation UIButton (SPKitButton)
- (void)ln_expandHitBoundsWithEdgeInsets:(UIEdgeInsets)insets {
    id<AspectToken> token = objc_getAssociatedObject(self, @selector(pointInside:withEvent:));
    [token remove];
    token = [self aspect_hookSelector:@selector(pointInside:withEvent:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info) {
        CGRect originFrame = self.bounds;
        UIEdgeInsets relativeInsets = UIEdgeInsetsMake(-insets.top, -insets.left, -insets.bottom, -insets.right);
        CGRect hitFrame = UIEdgeInsetsInsetRect(originFrame, relativeInsets);
        CGPoint hitPoint = [[info arguments][0] CGPointValue];
        BOOL ret = CGRectContainsPoint(hitFrame, hitPoint);
        [[info originalInvocation] setReturnValue:&ret];
    } error:NULL];
    objc_setAssociatedObject(self, @selector(pointInside:withEvent:), token, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
