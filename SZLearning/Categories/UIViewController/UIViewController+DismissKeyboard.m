//
//  UIViewController+DismissKeyboard.m
//  test
//
//  Created by Apple on 15/3/6.
//  Copyright (c) 2015年 Wushengzhong. All rights reserved.
//

#import "UIViewController+DismissKeyboard.h"

@implementation UIViewController (DismissKeyboard)

- (void)setupForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakSelf = self;
    
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}


- (void)dismissToRootViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    UIViewController *viewController = self;
    while (viewController.presentingViewController) {
        viewController = viewController.presentingViewController;
    }
    
    [viewController dismissViewControllerAnimated:animated completion:completion];
}


@end
