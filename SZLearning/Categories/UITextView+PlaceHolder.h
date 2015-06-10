//
//  UITextView+PlaceHolder.h
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  UITextView 添加 placeholder 和色值 属性
 */

@interface UITextView (PlaceHolder) <UITextViewDelegate>

@property (nonatomic, strong) UITextView *placeHolderTextView;

///placeholder
@property (nonatomic, strong) NSString *placeholder;
///placeholderColor
@property (nonatomic, strong) UIColor *placeholderColor;

- (void)setPlaceholder:(NSString *)placeholder;

@end
