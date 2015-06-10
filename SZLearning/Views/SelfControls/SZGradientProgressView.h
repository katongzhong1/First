//
//  SZGradientProgressView.h
//  SZWIOSLearning
//
//  Created by Apple on 15/5/11.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 *  颜色梯度进度条  (教程: https://nrj.io/animated-progress-view-with-cagradientlayer )
 */

@interface SZGradientProgressView : UIView {
    
    CALayer *maskLayer;
}

@property (nonatomic, readonly, getter=isAnimating) BOOL animating;
@property (nonatomic, readwrite, assign) CGFloat progress;

- (void)startAnimating;
- (void)stopAnimating;


@end
