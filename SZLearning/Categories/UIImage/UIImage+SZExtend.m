//
//  UIImage+SZExtend.m
//  SZWIOSLearning
//
//  Created by Apple on 15/5/6.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "UIImage+SZExtend.h"



@implementation UIImage (SZExtend)


#pragma mark - 截屏
+ (UIImage *)cutScreen{
    return [self cutFromView:[UIApplication sharedApplication].keyWindow];
}

+ (UIImage *)cutFromView:(UIView *)view{
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, 1, 0);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //在新建的图形上下文中渲染view的layer
    [view.layer renderInContext:context];
    [[UIColor clearColor] setFill];
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)cutWithFrame:(CGRect)frame{
    //创建CGImage
    CGImageRef cgimage = CGImageCreateWithImageInRect(self.CGImage, frame);
    //创建image
    UIImage *newImage=[UIImage imageWithCGImage:cgimage];
    //释放CGImage
    CGImageRelease(cgimage);
    return newImage;
}

#pragma mark - 通过文件名获取图片

/* 通过文件名获取图片  自动适配@2x、@3x */
+ (UIImage *)imageWithFileName:(NSString *)name {
    NSString *extension = @"png";
    
    NSArray *components = [name componentsSeparatedByString:@"."];
    if ([components count] >= 2) {
        NSUInteger lastIndex = components.count - 1;
        extension = [components objectAtIndex:lastIndex];
        
        name = [name substringToIndex:(name.length-(extension.length+1))];
    }
    
    // 如果为Retina屏幕且存在对应图片，则返回Retina图片，否则查找普通图片
    if ([UIScreen mainScreen].scale == 2.0) {
        name = [name stringByAppendingString:@"@2x"];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    if ([UIScreen mainScreen].scale == 3.0) {
        name = [name stringByAppendingString:@"@3x"];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:extension];
    if (path) {
        return [UIImage imageWithContentsOfFile:path];
    }
    
    return nil;
}

@end







