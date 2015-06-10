//
//  UIColor+SZExtend.h
//  SZWIOSLearning
//
//  Created by Apple on 15/5/8.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIColor (SZExtend)

/* 随机颜色 */
+ (UIColor *)randomColor;

/* 十六进制颜色 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;

/* 十六进制颜色:含alpha */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha;

/* 渐变color gradient */
+ (UIColor*)gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;

@end
