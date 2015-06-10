//
//  NSNull+InternalNullExtention.h
//  Uthing3.0
//
//  Created by Apple on 15/3/24.
//  Copyright (c) 2015年 wushengzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSNullObjects @[@"",@0,@{},@[]]

//对网络数据返回null的处理
@interface NSNull (InternalNullExtention)
@end
