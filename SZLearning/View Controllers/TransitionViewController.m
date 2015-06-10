//
//  TransitionViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/23.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()

///<#说明#>
@property (nonatomic, strong) CALayer *colorLayer;

///<#说明#>
@property (nonatomic, strong) UIView *layerView;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //create a red layer
    self.layerView = [UIView new];
    self.layerView.frame = CGRectMake(0, 0, 200, 200);
    self.layerView.center = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
    self.layerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.layerView];
    
    
    //create timing function
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    //get control points
    CGPoint controlPoint1 = CGPointZero;
    CGPoint controlPoint2 = CGPointZero;
    [function getControlPointAtIndex:1 values:(float *)&controlPoint1];
    [function getControlPointAtIndex:2 values:(float *)&controlPoint2];
    //create curve
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1)
            controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    //scale the path up to a reasonable size for display
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 4.0f;
    shapeLayer.path = path.CGPath;
    [self.layerView.layer addSublayer:shapeLayer];
    //flip geometry so that 0,0 is in the bottom-left
    self.layerView.layer.geometryFlipped = YES;
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self changeColor];
    
    //configure the transaction
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    //set the position
    self.colorLayer.position = [[touches anyObject] locationInView:self.view];
    //commit transaction
    [CATransaction commit];
}

- (void)changeColor {
    //create a keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[(__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor
                         ];
    //add timing funciton
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunction = fn;
    
    [self.colorLayer addAnimation:animation forKey:nil];
}


@end
