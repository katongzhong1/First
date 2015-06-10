//
//  SZWTabBarViewController.h
//  SZLearning
//
//  Created by Apple on 15/5/26.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *   FoldingTabBar  https://github.com/Yalantis/FoldingTabBar.iOS
 */

@interface SZWTabBarViewController : UITabBarController

///<#说明#>
@property (nonatomic, strong) NSArray *leftBarItems;
///<#说明#>
@property (nonatomic, strong) NSArray *rightBarItems;
///<#说明#>
@property (nonatomic, strong) UIImage *centerButtonImage;
///<#说明#>
@property (nonatomic, assign) CGFloat tabBarViewHeight;
///<#说明#>
//@property (nonatomic, strong) <#属性#> <#名称#>;

@end
