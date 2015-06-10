//
//  RainbowNode.m
//  SZLearning
//
//  Created by Apple on 15/5/18.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "RainbowNode.h"

#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>

@implementation RainbowNode


- (NSObject *)drawParametersForAsyncLayer:(_ASDisplayLayer *)layer {
    return @(self.orientation);
}


+ (void)drawRect:(CGRect)bounds
  withParameters:(id<NSObject>)parameters
     isCancelled:(asdisplaynode_iscancelled_block_t)isCancelledBlock
   isRasterizing:(BOOL)isRasterizing
{
    // clear the backing store, but only if we're not rasterising into another layer
    if (!isRasterizing) {
        [[UIColor whiteColor] set];
        UIRectFill(bounds);
    }
    
    // UIColor sadly lacks +indigoColor and +violetColor methods
    NSArray *colors = @[ [UIColor redColor],
                         [UIColor orangeColor],
                         [UIColor yellowColor],
                         [UIColor greenColor],
                         [UIColor blueColor],
                         [UIColor purpleColor] ];
    
    BOOL isHor = [(NSNumber *)parameters integerValue] == 0 ? YES : NO;
    CGFloat stripeTotal = isHor ? bounds.size.height : bounds.size.width;
    CGFloat stripePadding = roundf(stripeTotal / (float)colors.count);
    
   

    // draw the stripes
    for (UIColor *color in colors) {
        CGRect stripe = CGRectZero;
        CGRectEdge stripeEdge = isHor ? CGRectMinYEdge:CGRectMinXEdge;
        CGRectDivide(bounds, &stripe, &bounds, stripePadding, stripeEdge);
        [color set];
        UIRectFill(stripe);
    }
}

@end
