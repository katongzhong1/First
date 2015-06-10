//
//  FoldingImageNode.m
//  SZLearning
//
//  Created by Apple on 15/5/21.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "FoldingImageNode.h"

//#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>

typedef NS_ENUM(NSInteger, LayerSection) {
    LayerSectionTop,
    LayerSectionBottom
};

@interface FoldingImageNode ()

///top
@property (nonatomic, strong) ASImageNode *oneImageNode;
///<#说明#>
@property (nonatomic, strong) ASImageNode *otherImageNode;

/// image
@property (nonatomic, strong) UIImage *imageData;

@property(nonatomic) NSUInteger initialLocation;

@end

@implementation FoldingImageNode

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image {
    if (self = [super init]) {
        self.frame = frame;
        _imageData = image;
        self.backgroundColor = [UIColor randomFlatColor];
        
        [self addSubnode];
        
        
    }
    return self;
}

- (void)addSubnode {
    // one
    _oneImageNode = [[ASImageNode alloc] init];
    _oneImageNode.image = [self imageForSection:LayerSectionTop withImage:_imageData];
    [self addSubnode:_oneImageNode];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [_oneImageNode.view addGestureRecognizer:panGestureRecognizer];
    
    // other
    _otherImageNode = [[ASImageNode alloc] init];
    _otherImageNode.image = [self imageForSection:LayerSectionBottom withImage:_imageData];
    [self addSubnode:_otherImageNode];
    
    _oneImageNode.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetMidY(self.bounds));
    _otherImageNode.frame = CGRectMake(0, CGRectGetMidY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetMidY(self.bounds));
    
    //[self addGestureRecognizers];
}


#pragma mark - handle

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.initialLocation = location.y;
    }
    
    if ([[_oneImageNode.layer valueForKeyPath:@"transform.rotation.x"] floatValue] < -M_PI_2) {
        
    }
    
    if ([self isLocation:location inView:self.view]) {
        CGFloat conversionFactor = -M_PI / (CGRectGetHeight(self.bounds) - self.initialLocation);
        POPBasicAnimation *rotationAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
        rotationAnimation.duration = .01;
        rotationAnimation.toValue = @((location.y-self.initialLocation)*conversionFactor);
        [_oneImageNode.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    } else {
        recognizer.enabled = NO;
        recognizer.enabled = YES;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded ||
        recognizer.state == UIGestureRecognizerStateCancelled ) {
        [self rotateToOriginWithVelocity:0];
    }
    
}

#pragma mark - Private

- (void)rotateToOriginWithVelocity:(CGFloat)velocity
{
    POPSpringAnimation *rotationAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationX];
    if (velocity > 0) {
        rotationAnimation.velocity = @(velocity);
    }
    rotationAnimation.springBounciness = 18.0f;
    rotationAnimation.dynamicsMass = 2.0f;
    rotationAnimation.dynamicsTension = 200;
    rotationAnimation.toValue = @(0);
    rotationAnimation.delegate = self;
    [_oneImageNode.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (BOOL)isLocation:(CGPoint)location inView:(UIView *)view
{
    if ((location.x > 0 && location.x < CGRectGetWidth(self.bounds)) &&
        (location.y > 0 && location.y < CGRectGetHeight(self.bounds))) {
        return YES;
    }
    return NO;
}

- (void)addGestureRecognizers
{
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        
        //UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(poke)];
        
        [_oneImageNode.view addGestureRecognizer:panGestureRecognizer];
        //[_oneImageNode.view addGestureRecognizer:tapGestureRecognizer];
 
}

- (UIImage *)imageForSection:(LayerSection)section withImage:(UIImage *)image {
    NSInteger scale = [UIScreen mainScreen].scale;
    CGRect rect = CGRectMake(0.f, 0.f, image.size.width*scale, image.size.height*scale / 2.f);
    if (section == LayerSectionBottom) {
        rect.origin.y = image.size.height*scale / 2.f;
    }
    
    CGImageRef imgRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *imagePart = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    
    return imagePart;
}

@end
