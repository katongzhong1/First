//
//  TransformViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/22.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "TransformViewController.h"

#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

static const NSInteger BTN_TAG = 1000;

@interface TransformViewController ()

/// 容器视图
@property (nonatomic, strong) UIView *containerView;
/// 图层组
@property (nonatomic, strong) NSArray *faces;
/// CATextLayer
@property (nonatomic, strong) UIView *labelView;

@property (nonatomic, strong)  UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIButton *changeColorButton;

@end

@implementation TransformViewController



#pragma mark - Life cycle            //生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor flatGrayColor];
    
    // transform
    [self.view addSubview:self.containerView];
    [self addTransforms];
    
    // CATextLayer
    [self addTextLayer];
    
    [self.view addSubview:self.labelView];
    [self.view addSubview:self.changeColorButton];
    
}

#pragma mark - Delegate              //所有代理方法  顺序


#pragma mark - Event response        //事件回应

- (void)btnClick:(UIButton *)sender {
    NSLog(@"outch ! 正方体 第 %li 面被点击了", sender.tag - BTN_TAG);
    
    if (sender == _changeColorButton) {
        //增加 隐示动画 的时间
        //begin a new transaction
        [CATransaction begin];
        
        // 禁 隐示动画
        //[CATransaction setDisableActions:YES];
        
        /**
         *  UIView直接通过返回nil来禁用隐式动画。每个UIView对它关联的图层都扮演了一个委托，并且提供了-actionForLayer:forKey的实现方法。
         */
        
        //set the animation duration to 1 second
        [CATransaction setAnimationDuration:2.0];
        //add the spin animation on completion
        [CATransaction setCompletionBlock:^{
            //rotate the layer 90 degrees
//            CGAffineTransform transform = self.colorLayer.affineTransform;
//            transform = CGAffineTransformRotate(transform, M_PI_2);
//            self.colorLayer.affineTransform = transform;
        }];
        self.colorLayer.backgroundColor = [UIColor randomColor].CGColor;
        //commit the transaction
        [CATransaction commit];
        
        /**
         *  UIView有两个方法，+beginAnimations:context:和+commitAnimations，和CATransaction的+begin和+commit方法类似。实际上在+beginAnimations:context:和+commitAnimations之间所有视图或者图层属性的改变而做的动画都是由于设置了CATransaction的原因
         */
    }
}

#pragma mark - Private methods       //私有方法

#pragma mark  1. Transform

- (void)addTransforms {
    //set up the container sublayer transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;
    //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 75);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(75, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -75, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 75, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-75, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -75);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform {
    UIView *face = self.faces[index];
    [self.containerView addSubview:face];
    
    CGSize containerSize = self.containerView.bounds.size;
    face.center = CGPointMake(containerSize.width/2.0, containerSize.height/2.0);
    
    face.layer.transform = transform;
    
    //apply lighting
    [self applyLightingToFace:face.layer];
}

- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

#pragma mark   2. CATextLayer

- (void)addTextLayer {
    //create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.labelView.bounds;
    [self.labelView.layer addSublayer:textLayer];
    
    //set text attributes
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    CGFontRelease(fontRef);
    
    //choose some text
    NSString *text = @"Lorem ipsum dolor sit amet";
    
    //set layer text
    textLayer.string = text;
}

#pragma mark - Getters and Setters   //设置方法

- (NSArray *)faces {
    if (!_faces) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for (NSUInteger i=0; i<6; i++) {
            UIButton *button = [UIButton button];
            button.frame = CGRectMake(0, 0, 150, 150);
            [button setTitle:[@(i+1) stringValue] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor randomFlatColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:24];
            button.backgroundColor = [UIColor whiteColor];
            button.tag = BTN_TAG + i;
            if (i != 2) {
                button.userInteractionEnabled = NO;
            }
            
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [array addObject:button];
        }
        _faces = [NSArray arrayWithArray:array];
    }
    return _faces;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
        _containerView.center = self.view.center;
        _containerView.userInteractionEnabled = YES;
    }
    return _containerView;
}

#pragma mark   2. 隐示动画
- (UIView *)labelView {
    if (!_labelView) {
        _labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 200, 70)];
        
        self.colorLayer = [CALayer layer];
        self.colorLayer.frame = CGRectMake(20.0f, 10.0f, 160.0f, 80.0f);
        self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
        
        //add a custom action
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        self.colorLayer.actions = @{@"backgroundColor": transition};
        //add it to our view
        
        [_labelView.layer addSublayer:self.colorLayer];
    }
    return _labelView;
}

- (UIButton *)changeColorButton {
    if (!_changeColorButton) {
        _changeColorButton = [UIButton button];
        _changeColorButton.frame = CGRectMake(220, 94, 60, 40);
        [_changeColorButton setTitle:@"color" forState:UIControlStateNormal];
        [_changeColorButton setTitleColor:[UIColor randomFlatColor] forState:UIControlStateNormal];
        _changeColorButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _changeColorButton.backgroundColor = [UIColor redColor];
        
        [_changeColorButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeColorButton;
}


@end
