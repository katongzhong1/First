//
//  UIImage+Color.h
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/* 获取纯色图片 */
+ (UIImage *)imageFromColor:(UIColor *)color;

/* UIImage 某点的 color */
- (UIColor *)colorAtPoint:(CGPoint )point;

//more accurate method ,colorAtPixel 1x1 pixel
/* UIImage 某个像素点的 color */
- (UIColor *)colorAtPixel:(CGPoint)point;

@end
