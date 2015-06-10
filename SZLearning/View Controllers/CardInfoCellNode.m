//
//  CardInfoCellNode.m
//  SZLearning
//
//  Created by Apple on 15/5/18.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "CardInfoCellNode.h"

#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>
#import "ASGradientNode.h"

#define textAreaHeight 300.0
#define cardWidth      320.0

@interface CardInfoCellNode ()

///背景
@property (nonatomic, strong) ASImageNode *placeholderLayer;
///
@property (nonatomic, strong) NSOperation *nodeConstructionOperation;
///
@property (nonatomic) CGSize featureImageSizeOptional;
///<#说明#>
@property (nonatomic, strong) ASImageNode *backgroundImageNode;
///<#说明#>
@property (nonatomic, strong) ASImageNode *featureImageNode;
///<#说明#>
@property (nonatomic, strong) ASDisplayNode *containerNode;
@property (nonatomic, strong) ASTextNode    *titleTextNode;
@property (nonatomic, strong) ASTextNode    *descriptionTextNode;
///<#说明#>
@property (nonatomic, strong) ASGradientNode *gradientNode;
@end

@implementation CardInfoCellNode

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor blackColor];

        [self addLayer];
    }
    return self;
}

- (void)addLayer {
    
    _containerNode = [[ASDisplayNode alloc] init];
    _containerNode.layerBacked = YES;
    _containerNode.shouldRasterizeDescendants = YES;
    _containerNode.borderWidth = 1;
    _containerNode.borderColor =[UIColor colorWithHue:0 saturation:0 brightness:0.85 alpha:0.2].CGColor;
    //_containerNode.image = [UIImage imageNamed:@"cardPlaceholder"];
    
    
    //添加背景
    _backgroundImageNode = [[ASImageNode alloc] init];
    _backgroundImageNode.contentMode = UIViewContentModeScaleToFill;
    _backgroundImageNode.layerBacked = YES;
    _backgroundImageNode.imageModificationBlock = ^(UIImage *image){
        image = [image applyBlurWithRadius:30 tintColor:[UIColor colorWithWhite:.5 alpha:.3] saturationDeltaFactor:1.8 maskImage:nil];
        return image;
    };
    
    _featureImageNode = [[ASImageNode alloc] init];
    _featureImageNode.contentMode = UIViewContentModeScaleToFill;
    _featureImageNode.layerBacked = YES;
    
    _titleTextNode = [[ASTextNode alloc] init];
    _titleTextNode.layerBacked = YES;
    _titleTextNode.backgroundColor = [UIColor clearColor];

    _descriptionTextNode = [[ASTextNode alloc] init];
    _descriptionTextNode.layerBacked = YES;
    _descriptionTextNode.backgroundColor = [UIColor clearColor];
    
    _gradientNode = [[ASGradientNode alloc] init];
    _gradientNode.opaque = NO; //设置 不透明 为NO
    _gradientNode.layerBacked = YES;
    
    [_containerNode addSubnode:_backgroundImageNode];
    [_containerNode addSubnode:_featureImageNode];
    [_containerNode addSubnode:_gradientNode];
    [_containerNode addSubnode:_titleTextNode];
    [_containerNode addSubnode:_descriptionTextNode];
    
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
    if (_featureImageSizeOptional.width>0) {
        CGRect frame = [self frameForContainerWithFeatuerImageSize:_featureImageSizeOptional];
        return CGSizeMake(frame.size.width, frame.size.height+10);
    }
    return CGSizeMake(cardWidth, 500);
}

- (void)layout {
    
    _containerNode.frame = [self frameForContainerWithFeatuerImageSize:_featureImageSizeOptional];
    _backgroundImageNode.frame = [self frameForContainerWithFeatuerImageSize:_featureImageSizeOptional];
    _featureImageNode.frame = [self frameForFeatureImageWithFeatureImageSize:CGSizeMake(_featureImageSizeOptional.width+1, _featureImageSizeOptional.height) containerFrameWidth:self.bounds.size.width];
    _titleTextNode.frame = [self frameForTitleTextWithContainerBounds:self.bounds featureImageFrame:_featureImageNode.frame];
    _descriptionTextNode.frame = [self frameForDescriptionText:self.bounds featureImageFrame:_featureImageNode.frame];
    _gradientNode.frame = [self frameForGradientWithFeatureImageFrame:_featureImageNode.frame];
    
    [self.layer addSublayer:_containerNode.layer];
}

- (void)configureCellDisplayWithCardInfo:(CardInfoModel *)model nodeConstructionQueue:(NSOperationQueue *)queue {
    
    UIImage *image = [UIImage imageNamed:model.imageName];
    _featureImageSizeOptional = image.size;
    _backgroundImageNode.image = image;
    _featureImageNode.image = image;
    
    _titleTextNode.attributedString = [self attributedStringForTitleText:model.name];
    _descriptionTextNode.attributedString = [self attributedStringForDescriptionText:model.descriptionString];
}

#pragma mark - NSAttributeString

- (NSAttributedString *)attributedStringForTitleText:(NSString *)text {
    NSDictionary *titleAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Heavy" size:30],
                                           NSShadowAttributeName: [self titleTextShadow],
                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                           NSParagraphStyleAttributeName: [self justifiedParagraphStyle]};
    return [[NSAttributedString alloc] initWithString:text attributes:titleAttributes];
}

- (NSAttributedString *)attributedStringForDescriptionText:(NSString *)text {
    NSDictionary *descriptionAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Medium" size:16],
                                           NSShadowAttributeName: [self desriptionShadow],
                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                           NSBackgroundColorAttributeName: [UIColor clearColor],
                                           NSParagraphStyleAttributeName: [self justifiedParagraphStyle]};
    return [[NSAttributedString alloc] initWithString:text attributes:descriptionAttributes];
}

- (NSParagraphStyle *)justifiedParagraphStyle {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    return [paragraphStyle copy];
}

- (NSShadow *)desriptionShadow {
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithWhite:0 alpha:.3];
    shadow.shadowOffset = CGSizeMake(0, 1);
    shadow.shadowBlurRadius = 3.0;
    return shadow;
}

- (NSShadow *)titleTextShadow {
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:.3];
    shadow.shadowOffset = CGSizeMake(0, 2);
    shadow.shadowBlurRadius = 3.0;
    return shadow;
}

#pragma mark - Frame

- (CGRect)frameForDescriptionText:(CGRect)containerBounds featureImageFrame:(CGRect)featureImageFrame {
    return CGRectMake(24.0, CGRectGetMaxY(featureImageFrame)+20.0, containerBounds.size.width-48.0, textAreaHeight);
}

- (CGRect)frameForTitleTextWithContainerBounds:(CGRect)containerBounds featureImageFrame:(CGRect)featureImageFrame {
    CGRect frameForTitleText = CGRectMake(0, CGRectGetMaxY(featureImageFrame)-70.0, containerBounds.size.width, 80);

    return CGRectMake(frameForTitleText.origin.x+20, frameForTitleText.origin.y+20, frameForTitleText.size.width-40, frameForTitleText.size.height-40);
}

- (CGRect)frameForGradientWithFeatureImageFrame:(CGRect)featureImageFrame {
    return featureImageFrame;
}

- (CGRect)frameForFeatureImageWithFeatureImageSize:(CGSize)featureImageSize containerFrameWidth:(CGFloat)containerFrameWidth {
    CGSize imageFrame = [self aspectSizeForWidth:containerFrameWidth originalSize:featureImageSize];
    return CGRectMake(0, 0, imageFrame.width, imageFrame.height);
}

- (CGRect)frameForBackgroundImageWithContainerBounds:(CGRect)containerBounds {
    return containerBounds;
}

- (CGRect)frameForContainerWithFeatuerImageSize:(CGSize)featureImageSize {
    CGSize size = [self sizeThatFits:CGSizeMake(cardWidth, CGFLOAT_MAX) imageSize:featureImageSize];
    return CGRectMake(0, 0, cardWidth, size.height);
}

- (CGSize)sizeThatFits:(CGSize)size imageSize:(CGSize)imageSize {
    CGSize imageFrameSize = [self aspectSizeForWidth:size.width originalSize:imageSize];
    return CGSizeMake(size.width, imageFrameSize.height+ textAreaHeight);
}

- (CGSize)aspectSizeForWidth:(CGFloat)width originalSize:(CGSize)originalSize {
    CGFloat height = ceil((originalSize.height/originalSize.width) * width);
    return CGSizeMake(width, height);
}

@end
