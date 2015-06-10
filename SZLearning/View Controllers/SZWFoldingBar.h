//
//  SZWFoldingBar.h
//  SZLearning
//
//  Created by Apple on 15/5/26.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZWFoldingBar;

@protocol SZWTabBarViewDataSource <NSObject>
@required
- (NSArray *)leftTabBarItemsInTabBarView:(SZWFoldingBar *)tabBarView;
- (NSArray *)rightTabBarItemsInTabBarView:(SZWFoldingBar *)tabBarView;
- (UIImage *)centerImageInTabBarView:(SZWFoldingBar *)tabBarView;
@end

typedef NS_ENUM(NSUInteger, SZWTabBarState) {
    SZWTabBarStateCollapsed,
    SZWTabBarStateExpand
};

@interface SZWFoldingBar : UIView

- (instancetype)initWithFrame:(CGRect)frame state:(SZWTabBarState)state;


///<#说明#>
@property (nonatomic, assign, readonly) SZWTabBarState state;
///<#说明#>
@property (nonatomic, assign) NSUInteger selectedTabBarItemIndex;

///<#说明#>
@property (nonatomic, weak) id<SZWTabBarViewDataSource> dataSource;

///<#说明#>
@property (nonatomic, strong) UIColor *tabBarColor;
@property (nonatomic, assign) UIEdgeInsets tabBarViewEdgeInsets;
///<#说明#>
@property (nonatomic, assign) UIEdgeInsets tabBarItemsEdgeInsets;
///<#说明#>
@property (nonatomic, assign) CGFloat extraTabBarItemHeight;
///<#说明#>
@property (nonatomic, assign) CGFloat offsetForExtraTabBarItems;


@end
