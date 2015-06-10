//
//  UIViewController+DismissKeyboard.h
//  test
//
//  Created by Apple on 15/3/6.
//  Copyright (c) 2015年 Wushengzhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自动回收键盘   
 */

@interface UIViewController (DismissKeyboard)

/* viewDidLoad 里面调用此方法 */
- (void)setupForDismissKeyboard;

/*  */
- (void)dismissToRootViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end
