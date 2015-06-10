//
//  UIView+SZExtend.m
//  SZWIOSLearning
//
//  Created by Apple on 15/5/6.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "UIView+SZExtend.h"

#import <objc/runtime.h>

@implementation UIView (SZExtend)

#pragma mark - 扩大view的点击范围的实现方法

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";
static BOOL SZHasSwizzledSetFrame;

#pragma mark   == 1.Public

- (void)sz_extendHitTestSizeByWidth:(CGFloat)width andHeight:(CGFloat)height {
    // As they are stored as a UIEdgeInset and we're dealing with extending
    // we invert the height & width to make the API make sense
    UIEdgeInsets insets = UIEdgeInsetsMake(-height, -width, -height, -width);
    NSValue *value = [NSValue value:&insets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if (value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

#pragma mark   == 2.Private
// Support showing what it would look like at runtime
// We need to ensure that setting the frame resizes correctly
// Thus swizzling only when at least one view uses the visually method
- (void)sz_visuallyExtendHitTestSizeByWidth:(CGFloat)width andHeight:(CGFloat)height
{
    UIEdgeInsets highlightInsets = UIEdgeInsetsMake(-height, -width, -height, -width);
    NSInteger highlightViewTag = 232323;
    
    UIView *highlightView = [self viewWithTag:highlightViewTag];
    if (!highlightView) {
        highlightView = [[UIView alloc] init];
        highlightView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5];
        highlightView.tag = 232323;
        highlightView.userInteractionEnabled = NO;
        self.clipsToBounds = NO;
        [self addSubview:highlightView];
    }
    
    highlightView.frame = UIEdgeInsetsInsetRect(self.bounds, highlightInsets);
    
    [self sz_extendHitTestSizeByWidth:width andHeight:height];
    
    if (!SZHasSwizzledSetFrame){
        SZHasSwizzledSetFrame = YES;
        
        SEL setFrame = @selector(layoutSubviews);
        SEL newSetFrame = @selector(swizzledLayoutSubviews);
        
        Method originalMethod = class_getInstanceMethod(self.class, setFrame);
        Method overrideMethod = class_getInstanceMethod(self.class, newSetFrame);
        if (class_addMethod(self.class, setFrame, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
            class_replaceMethod(self.class, newSetFrame, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, overrideMethod);
        }
    }
}

- (void)swizzledLayoutSubviews
{
    [self swizzledLayoutSubviews];
    
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if (value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets];
        [self sz_visuallyExtendHitTestSizeByWidth:-edgeInsets.left andHeight:-edgeInsets.top];
    }
}

@end
