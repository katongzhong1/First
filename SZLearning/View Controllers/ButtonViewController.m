//
//  ButtonViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/21.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "ButtonViewController.h"

typedef struct {
    CGFloat progress;
    CGFloat toValue;
    CGFloat currentValue;
} AnimationInfo;

@interface ButtonViewController ()

///图片
@property (nonatomic, strong) ASImageNode *imageNode;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ButtonViewController



#pragma mark -Life cycle            //生命周期

- (instancetype)init {
    if (self = [super init]) {
        [self preConfigTheSubview];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTheFace];
    
    [self.view addSubview:_imageNode.view];
    [self scaleDownView:_imageNode.view];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePan:)];
    [_imageNode.view addGestureRecognizer:recognizer];
    
}



#pragma mark -Delegate              //所有代理方法  顺序


#pragma mark -Event response        //事件回应

- (void)touchDown:(ASImageNode *)sender {
    [self pauseAllAnimations:YES forLayer:sender.layer];
}

- (void)touchUpInside:(ASImageNode *)sender {
    AnimationInfo animationInfo = [self animationInfoForLayer:sender.layer];
    BOOL hasAnimations = sender.layer.pop_animationKeys.count;
    
    if (hasAnimations && animationInfo.progress < 0.98) {
        [self pauseAllAnimations:NO forLayer:sender.layer];
        return;
    }
    
    [sender.layer pop_removeAllAnimations];
    if (animationInfo.toValue == 1 || sender.layer.affineTransform.a == 1) {
        [self scaleDownView:sender.view];
        return;
    }
    [self scaleUpView:sender.view];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    [self scaleDownView:recognizer.view];
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        positionAnimation.dynamicsTension = 10.f;
        positionAnimation.dynamicsFriction = 1.0f;
        positionAnimation.springBounciness = 12.0f;
        [recognizer.view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
}


#pragma mark -Private methods       //私有方法

- (void)configTheFace {
    self.view.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor randomFlatColor];
}

- (void)preConfigTheSubview {
    
    // imageNode
    _imageNode = [[ASImageNode alloc] init];
    _imageNode.frame = CGRectMake(0, 0, 300, 200);
    _imageNode.position = self.view.center;
    _imageNode.cornerRadius = 5;
    _imageNode.clipsToBounds = YES;
    _imageNode.image = [UIImage imageNamed:@"margay"];
    
    [_imageNode addTarget:self action:@selector(touchDown:) forControlEvents:ASControlNodeEventTouchDown];
    [_imageNode addTarget:self action:@selector(touchUpInside:) forControlEvents:ASControlNodeEventTouchUpInside];

}

- (void)pauseAllAnimations:(BOOL)pause forLayer:(CALayer *)layer
{
    for (NSString *key in layer.pop_animationKeys) {
        POPAnimation *animation = [layer pop_animationForKey:key];
        [animation setPaused:pause];
    }
}

- (AnimationInfo)animationInfoForLayer:(CALayer *)layer
{
    POPSpringAnimation *animation = [layer pop_animationForKey:@"scaleAnimation"];
    CGPoint toValue = [animation.toValue CGPointValue];
    CGPoint currentValue = [[animation valueForKey:@"currentValue"] CGPointValue];
    
    CGFloat min = MIN(toValue.x, currentValue.x);
    CGFloat max = MAX(toValue.x, currentValue.x);
    
    AnimationInfo info;
    info.toValue = toValue.x;
    info.currentValue = currentValue.x;
    info.progress = min / max;
    return info;
}

#pragma mark     Animation

-(void)scaleUpView:(UIView *)view
{
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
    [view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    scaleAnimation.springBounciness = 10.f;
    [view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)scaleDownView:(UIView *)view
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
    scaleAnimation.springBounciness = 10.f;
    [view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

#pragma mark -Getters and Setters   //设置方法

@end
