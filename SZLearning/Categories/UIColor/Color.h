//
//  Color.h
//  SZWIOSLearning
//
//  Created by Apple on 15/5/8.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "UIColor+SZExtend.h"

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

/* 传入字符串: aaaaaa 或 #aaaaaa 或  @"aaaaa" 或 @"#aaaaaa" */
#define HexColor(colorV) [UIColor colorWithHexColorString:@#colorV]
#define HexColorAlpha(colorV,a) [UIColor colorWithHexColorString:@#colorV alpha:a];


