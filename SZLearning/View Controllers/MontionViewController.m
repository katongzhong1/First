//
//  MontionViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/26.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "MontionViewController.h"
#import "SCImagePanViewController.h"

@interface MontionViewController ()
@property (nonatomic, strong) SCImagePanViewController *imagePanViewController;
@end

@implementation MontionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    self.imagePanViewController = [[SCImagePanViewController alloc] initWithMotionManager:motionManager];
    
    [self.imagePanViewController willMoveToParentViewController:self];
    
    [self addChildViewController:self.imagePanViewController];
    [self.view addSubview:self.imagePanViewController.view];
    
    self.imagePanViewController.view.frame = self.view.bounds;
    self.imagePanViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self.imagePanViewController didMoveToParentViewController:self];
    
    UIImage *panoramaImage = [UIImage imageNamed:@"melbourne.jpg"];
    [self.imagePanViewController configureWithImage:panoramaImage];
}

//- (UIViewController *)childViewControllerForStatusBarHidden
//{
//    return self.imagePanViewController;
//}
@end
