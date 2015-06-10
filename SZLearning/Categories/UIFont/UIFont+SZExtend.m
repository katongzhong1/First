//
//  UIFont+SZExtend.m
//  SZWIOSLearning
//
//  Created by Apple on 15/5/6.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "UIFont+SZExtend.h"

#import <CoreText/CoreText.h>

/* 自定义字体后缀名 */
typedef NS_ENUM(NSInteger, UTMFontSuffix) {
    UTMFontSuffixTtf,   // 后缀:ttf
    UTMFontSuffixOtf    // 后缀:otf
};

@interface UTMFontLoader: NSObject

+ (void)loadTtfFontWithFileName:(NSString *)fontFileName fontSuffix:(UTMFontSuffix)suffix;

@end

@implementation UTMFontLoader

+ (void)loadTtfFontWithFileName:(NSString *)fontFileName fontSuffix:(UTMFontSuffix)suffix{
    NSBundle *bundle = [NSBundle bundleForClass:self];
    NSString *suffixString;
    if (UTMFontSuffixTtf == suffix) {
        suffixString = @"ttf";
    } else if (UTMFontSuffixOtf == suffix) {
        suffixString = @"otf";
    }
    NSURL *fontURL = [bundle URLForResource:fontFileName withExtension:suffixString];
    NSData *fontData = [NSData dataWithContentsOfURL:fontURL];
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    
    if (font) {
        CFErrorRef errorRef = NULL;
        if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == NO) {
            NSError *error = (__bridge NSError *)errorRef;
            if (error.code == kCTFontManagerErrorAlreadyRegistered) {
                // nop - the font must have been registered by someone else already.
            } else {
                @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:error.localizedDescription userInfo:@{ NSUnderlyingErrorKey: error }];
            }
        }
        CFRelease(font);
    }
    CFRelease(provider);
}

@end



#pragma mark -

@implementation UIFont (SZExtend)

#pragma mark  - Default Method

/* 加载字体的默认实现方法 */
+ (instancetype)utm_LoadAndReturnFont:(NSString *)fontName size:(CGFloat)fontSize onceToken:(dispatch_once_t *)onceToken fontSuffix:(UTMFontSuffix)suffix {
    dispatch_once(onceToken, ^{
        [UTMFontLoader loadTtfFontWithFileName:fontName fontSuffix:suffix];
    });
    return [self fontWithName:fontName size:fontSize];
}

#pragma mark   添加自定义字体到UIFont下的fonts文件夹  绑定相应的方法

/**
 *  使用方法
 *
 *  @param size 字体大小
 */
+ (UIFont *)exampleFontWithSize:(CGFloat)size {
    static dispatch_once_t onceToken;
    return [self utm_LoadAndReturnFont:@"字体名称" size:size onceToken:&onceToken fontSuffix:UTMFontSuffixTtf];
}




#pragma mark  打印并显示所有字体
/* 打印并显示所有字体 */
+ (void)showAllFonts{
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
}

@end

















