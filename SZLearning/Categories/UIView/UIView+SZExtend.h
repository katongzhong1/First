//
//  UIView+SZExtend.h
//  SZWIOSLearning
//
//  Created by Apple on 15/5/6.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIView类别
 */

@interface UIView (SZExtend)

#pragma mark - 扩大view的点击范围
/* 实现方法 */
- (void)sz_extendHitTestSizeByWidth:(CGFloat)width andHeight:(CGFloat)height;
/* 测试方法 */
- (void)sz_visuallyExtendHitTestSizeByWidth:(CGFloat)width andHeight:(CGFloat)height;



@end
