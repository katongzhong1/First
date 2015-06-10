//
//  FXImageView.h
//
//  Version 1.3.5
//
//  Created by Nick Lockwood on 31/10/2011.
//  Copyright (c) 2011 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/FXImageView
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//


#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wobjc-missing-property-synthesis"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 *  FXImageView  集成图片的 倒影、自动下载、显示下载等待提示功能
 */

/* Category  UIImage+FX */

@interface FXImageView : UIImageView

+ (NSOperationQueue *)processingQueue;
+ (NSCache *)processedImageCache;

@property (nonatomic, assign, getter = isAsynchronous) BOOL asynchronous;
@property (nonatomic, assign) NSTimeInterval crossfadeDuration;

/* 倒影 与图片间的间隙 */
@property (nonatomic, assign) CGFloat reflectionGap;

/* 倒影 相对图片高的 占比 */
@property (nonatomic, assign) CGFloat reflectionScale;
/* 倒影 alpha 值 */
@property (nonatomic, assign) CGFloat reflectionAlpha;

/* 图片阴影 颜色 */
@property (nonatomic, strong) UIColor *shadowColor;
/* 图片阴影 size */
@property (nonatomic, assign) CGSize shadowOffset;
/* 图片阴影 模糊程度 */
@property (nonatomic, assign) CGFloat shadowBlur;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIImage *processedImage;
@property (nonatomic, assign) UIViewContentMode contentMode;

@property (nonatomic, copy) UIImage *(^customEffectsBlock)(UIImage *image);
@property (nonatomic, copy) NSString *cacheKey;

- (void)setImageWithContentsOfFile:(NSString *)file;
- (void)setImageWithContentsOfURL:(NSURL *)URL;

@end


#pragma GCC diagnostic pop
