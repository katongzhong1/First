//
//  UILabel+SZExtend.m
//  SZLearning
//
//  Created by wushengzhong on 15/6/10.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "UILabel+SZExtend.h"

@implementation UILabel (SZExtend)

/* 计算label内容的size */
- (CGSize)contentSize {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [self.text boundingRectWithSize:self.frame.size
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize;
}

@end
