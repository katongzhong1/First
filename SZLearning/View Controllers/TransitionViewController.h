//
//  TransitionViewController.h
//  SZLearning
//
//  Created by Apple on 15/5/23.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  ViewController Transition
 */

/**
 *  http://onevcat.com/2013/10/vc-transition-in-ios7/
 */

@interface TransitionViewController : UIViewController

@end




/**
 *  1.  UIPercentDrivenInteractiveTransition是什么 ?
        实现了UIViewControllerInteractiveTransitioning接口的类，
        为我们预先实现和提供了一系列便利的方法，可以用一个百分比来控制交互式切换的过程。
    
    2.
         -(void)updateInteractiveTransition:(CGFloat)percentComplete 更新百分比，一般通过手势识别的长度之类的来计算一个值，然后进行更新。之后的例子里会看到详细的用法
         -(void)cancelInteractiveTransition 报告交互取消，返回切换前的状态
         –(void)finishInteractiveTransition 报告交互完成，更新到切换后的状态
 */


/**
 *  💡 1. 研究  UIPercentDrivenInteractiveTransition  
 */
