//
//  TransformViewController.h
//  SZLearning
//
//  Created by Apple on 15/5/22.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  transform
 */

/**
 *  隐示动画
 
     1. UIView关联的图层禁用了隐式动画，对这种图层做动画的唯一办法就是使用UIView的动画函数（而不是依赖CATransaction），或者继承UIView，并覆盖-actionForLayer:forKey:方法，或者直接创建一个显式动画（具体细节见第八章）。
        对于单独存在的图层，我们可以通过实现图层的-actionForLayer:forKey:委托方法，或者提供一个actions字典来控制隐式动画。
 */

@interface TransformViewController : UIViewController

@end
