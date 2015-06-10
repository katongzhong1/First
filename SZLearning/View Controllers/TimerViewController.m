//
//  TimerViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/25.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

/// nstimer
@property (nonatomic, strong) NSTimer *nsTimer;
/// CADisplayLink
@property (nonatomic, strong) CADisplayLink *displayLink;
/// GCD
//@property (nonatomic, strong) <#属性#> <#名称#>;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //  1. nstimer
    self.nsTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.nsTimer forMode:NSDefaultRunLoopMode];
    // timer release
    [self.nsTimer invalidate];
    self.nsTimer = nil;
    
    
    //  2.  CADisplayLink
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timer)];
    // 可以同时对CADisplayLink指定多个run loop模式，于是我们可以同时加入NSDefaultRunLoopMode和UITrackingRunLoopMode来保证它不会被滑动打断，也不会被其他UIKit控件动画影响性能
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:UITrackingRunLoopMode];
    //  release
    [self.displayLink invalidate];
    self.displayLink = nil;
    
}

- (void)timer {
    
}

@end
