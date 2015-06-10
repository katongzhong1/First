//
//  FoldingAnimationViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/21.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "FoldingAnimationViewController.h"

#import "FoldingImageNode.h"

@interface FoldingAnimationViewController ()

///图片
@property (nonatomic, strong) FoldingImageNode *imageNode;

@end

@implementation FoldingAnimationViewController



#pragma mark -Life cycle            //生命周期

- (instancetype)init {
    if (self = [super init]) {
        [self preConfigTheSubview];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomFlatColor];
    
    
    [self.view addSubview:_imageNode.view];
}

#pragma mark -Delegate              //所有代理方法  顺序


#pragma mark -Event response        //事件回应


#pragma mark -Private methods       //私有方法

- (void)preConfigTheSubview {
    // imageNode
    UIImage *image = [UIImage imageNamed:@"margay"];
    _imageNode = [[FoldingImageNode alloc] initWithFrame:CGRectMake(0, 0, 320, 300) image:image];
    //_imageNode.frame = CGRectMake(0, 0, 240, 200);
    _imageNode.position = self.view.center;
    _imageNode.cornerRadius = 5;
    _imageNode.clipsToBounds = YES;
}


#pragma mark -Getters and Setters   //设置方法



@end
