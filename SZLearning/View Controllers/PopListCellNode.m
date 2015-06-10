//
//  PopListCellNode.m
//  SZLearning
//
//  Created by Apple on 15/5/21.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "PopListCellNode.h"

#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>

static const CGFloat kHorizontalPadding = 15.0f;
static const CGFloat kVerticalPadding = 10.0f;

@interface PopListCellNode ()

@property (nonatomic, strong) ASTextNode *textNode;

@end

@implementation PopListCellNode

- (instancetype)init {
    if (!(self = [super init])) return nil;
    
    [self addSubnode];
    return self;
}

- (void)addSubnode {
    //
    _textNode = [[ASTextNode alloc] init];
    [self addSubnode:_textNode];
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
}

- (void)layout {
    _textNode.frame = CGRectInset(self.bounds, kHorizontalPadding, kVerticalPadding);
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   [super touchesBegan:touches withEvent:event];
    
    _textNode.transform = CATransform3DIdentity;
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnimation.duration = 0.1;
    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
    scaleAnimation.delegate = self;
    [_textNode pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    scaleAnimation.springBounciness = 20.f;
    [_textNode.view pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    scaleAnimation.springBounciness = 20.f;
    [_textNode.view pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)setText:(NSString *)text
{
    if (_text == text)
        return;
    _text = [text copy];
    _textNode.attributedString = [[NSAttributedString alloc] initWithString:_text attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Avenir-Light" size:18]}];
    
    [self invalidateCalculatedSize];
}



@end
