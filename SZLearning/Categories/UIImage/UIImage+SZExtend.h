//
//  UIImage+SZExtend.h
//  SZWIOSLearning
//
//  Created by Apple on 15/5/6.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIImage类别
 */

@interface UIImage (SZExtend)




#pragma mark - 截图

/* 从给定UIView中截图:UIView转UIImage */
+ (UIImage *)cutFromView:(UIView *)view;

/* 直接截屏 */
+ (UIImage *)cutScreen;

/* 从给定UIImage和指定Frame截图 */
- (UIImage *)cutWithFrame:(CGRect)frame;


#pragma mark - 通过文件名获取图片 

/* 通过文件名获取图片  自动适配@2x、@3x */
+ (UIImage *)imageWithFileName:(NSString *)name;

@end
