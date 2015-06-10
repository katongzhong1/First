//
//  ASGradientNode.m
//  SZLearning
//
//  Created by Apple on 15/5/20.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "ASGradientNode.h"

#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>

@implementation ASGradientNode

+ (void)drawRect:(CGRect)bounds withParameters:(id<NSObject>)parameters isCancelled:(asdisplaynode_iscancelled_block_t)isCancelledBlock isRasterizing:(BOOL)isRasterizing {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(myContext);
    CGContextClipToRect(myContext, bounds);
    
    NSInteger comonentCount = 2;
    
    CGColorSpaceRef myColorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient = CGGradientCreateWithColorComponents(myColorSpace, (CGFloat[]){0.0, 0.0, 0.0, 1.0,
        0.0, 0.0, 0.0, 0.0}, (CGFloat[]){
            0.0, 1.0
        }, comonentCount);
    
    CGPoint myStartPoint = CGPointMake(CGRectGetMidX(bounds), CGRectGetMaxY(bounds));
    CGPoint myEndPoint = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    
    CGContextDrawLinearGradient(myContext, myGradient, myStartPoint, myEndPoint, (kCGGradientDrawsAfterEndLocation));
    
    CGContextRestoreGState(myContext);
}

@end
