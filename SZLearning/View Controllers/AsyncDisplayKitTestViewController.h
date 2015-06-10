//
//  AsyncDisplayKitTestViewController.h
//  SZLearning
//
//  Created by Apple on 15/5/18.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 *  AsyncDisplayKit 使用
 */

@interface AsyncDisplayKitTestViewController : UIViewController

@end

/* 最优化 */
  /* 1.Layer_backing  除了需要处理 touch 的所有自定义 node 都可以实现  node.layerBacked = YES */





/* 疑问 1. ASTextNode 是否支持多行文字 */
  /* 解决方案: 通过 measure 传入最大限制 Size 来控制 */

/* 疑问 2. ASRangeController 的使用 */



/* 💡 1. 是否可以实现 cell 内的点击事件的减耦合 : ASCellNode 和 url 跳转界面 合作 */