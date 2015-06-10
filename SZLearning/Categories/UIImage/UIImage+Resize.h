// UIImage+Resize.h
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Extends the UIImage class to support resizing/cropping
#import <UIKit/UIKit.h>

/**
 *  UIImage 的 裁减 和 改变大小
 */

@interface UIImage (Resize)

/* 裁减图片 bounds */
- (UIImage *)croppedImage:(CGRect)bounds;

/* 缩略图 可设置圆角、边框、图片质量 */
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;

/* 改变图片大小 可设置改变后图片质量 */
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;


- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;
@end
