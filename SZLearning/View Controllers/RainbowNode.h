//
//  RainbowNode.h
//  SZLearning
//
//  Created by Apple on 15/5/18.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "ASDisplayNode.h"

/**
 *  Custom drawing
 */

typedef NS_ENUM(NSUInteger, RainbowOrientation) {
    RainbowOrientationHorizontal,  //水平方向
    RainbowOrientationVertical     //垂直方向
};

@interface RainbowNode : ASDisplayNode

///rainbow 方向
@property (nonatomic) RainbowOrientation orientation;

@end
