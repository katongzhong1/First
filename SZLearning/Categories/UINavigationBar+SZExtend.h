//
//  UINavigationBar+SZExtend.h
//  SZLearning
//
//  Created by Apple on 15/5/13.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  使用: 动态修改 UINavigationBar 更容易
 */

/* 取自: https://github.com/ltebean/LTNavigationBar */

@interface UINavigationBar (SZExtend)

/* 设置导航条背景 颜色 */
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;

/* 设置导航条内容(不包含系统状态条) 透明度 */
- (void)lt_setContentAlpha:(CGFloat)alpha;

/* 设置导航条 44像素 的动画效果 */
- (void)lt_setTranslationY:(CGFloat)translationY;

/* 重置导航条 */
- (void)lt_reset;

@end


/**
 [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
 [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]];
 [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
 [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:21], NSFontAttributeName, nil]];
 [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
 */


/* 
 UINavigationBar
 
 navigationBar--导航条，iOS7以后默认是透明的，iOS7以前默认是不透明的。
 
 navigationBar在透明情况下，与contentView会重合一部分区域
 
 navigationBar在不透明情况，ContentView跟在navigationBar下面
 
 navigationBar竖屏下默认高度44，横屏下默认高度32
 */