//
//  UIColor+SZExtend.m
//  SZWIOSLearning
//
//  Created by Apple on 15/5/8.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//



#import "UIColor+SZExtend.h"


@implementation UIColor (SZExtend)

/* 随机颜色 */
+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0f green:arc4random_uniform(255)/255.0f blue:arc4random_uniform(255)/255.0f alpha:1.0f];
}

/* 十六进制颜色 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString {
    return [self colorWithHexColorString:hexColorString alpha:1.0f];
}

/* 十六进制颜色:含alpha */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha {
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    //排除掉  @\"
    if ([hexColorString hasPrefix:@"@\""]) {
        hexColorString = [hexColorString substringWithRange:NSMakeRange(2, hexColorString.length-3)];
    }
    
    //排除掉 #
    if ([hexColorString hasPrefix:@"#"]) {
        hexColorString = [hexColorString substringFromIndex:1];
    }
    
    if (nil != hexColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:hexColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:alpha];
    return result;
}

+ (UIColor*)gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height
{
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

@end
