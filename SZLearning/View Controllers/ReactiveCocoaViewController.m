//
//  ReactiveCocoaViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/25.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "ReactiveCocoaViewController.h"

@interface ReactiveCocoaViewController ()

@end

@implementation ReactiveCocoaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor randomColor];
    
    NSString *versionPath = @keypath(NSObject.class, version);
    NSLog(@"versionPath = %@", versionPath);
    
}

@end
