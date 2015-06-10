//
//  SZWFoldingBar.m
//  SZLearning
//
//  Created by Apple on 15/5/26.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "SZWFoldingBar.h"


@interface SZWFoldingBar ()

@property (nonatomic, strong) NSArray *allBarItems;

@property (nonatomic, assign) SZWTabBarState state;
//@property (nonatomic, assign) YALAnimatingState animatingState;
@property (nonatomic, assign) BOOL isFinishedCenterButtonAnimation;

@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, assign) BOOL isAnimated;

@property (nonatomic, assign) CGRect collapsedFrame;
@property (nonatomic, assign) CGRect expandedFrame;

@property (nonatomic, assign) CGRect collapsedBounds;
@property (nonatomic, assign) CGRect expandedBounds;

@property (nonatomic, assign) NSUInteger counter;

//buttons used instead of native tabBarItems to switch between controllers
@property (nonatomic, strong) NSArray *leftButtonsArray;
@property (nonatomic, strong) NSArray *rightButtonsArray;

//extra buttons 'tabBarItems' for each 'tabBarItem'
@property (nonatomic, strong) UIButton *extraLeftButton;
@property (nonatomic, strong) UIButton *extraRightButton;

//model representation of tabBarItems. also contains info for extraBarItems: image, color, etc
@property (nonatomic, strong) NSDictionary *leftTabBarItems;
@property (nonatomic, strong) NSDictionary *rightTabBarItems;

//array of all buttons just for simple switching between controllers by index
@property (nonatomic, strong) NSArray *allAdditionalButtons;
@property (nonatomic, strong) NSMutableArray *allAdditionalButtonsBottomView;

@end

@implementation SZWFoldingBar


#pragma mark - Initialations

- (instancetype)initWithFrame:(CGRect)frame state:(SZWTabBarState)state {
    if (self = [super initWithFrame:frame]) {
        _state = state;
        _selectedTabBarItemIndex = 0;
        _counter = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupUI];  /* 放在layout 里面   是否有影响？ */
}

#pragma mark - Private

- (void)setupUI {
    [self setMainView];
    [self setCenterButton];
    
    self.collapsedFrame = self.centerButton.frame;
    
    [self setupAdditionalTabBarItems];
}


- (void)setMainView {
    self.mainView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds, self.tabBarViewEdgeInsets)];
    self.expandedFrame = self.mainView.frame;
    self.mainView.layer.cornerRadius = CGRectGetHeight(self.mainView.bounds) / 2.f;
    self.mainView.layer.masksToBounds = YES;
    self.mainView.backgroundColor = self.tabBarColor;
    
    [self addSubview:self.mainView];
}

- (void)setCenterButton {
    CGFloat mainViewMidY = CGRectGetHeight(self.mainView.frame) / 2.0f;
    self.centerButton = [UIButton button];
    self.centerButton.frame = CGRectMake(CGRectGetMidX(self.mainView.frame) - mainViewMidY, CGRectGetMidY(self.mainView.frame) - mainViewMidY, mainViewMidY, mainViewMidY);
    
    self.centerButton.layer.cornerRadius = CGRectGetHeight(self.mainView.bounds) / 2.0f;
    
    // data Source
    if ([self.dataSource respondsToSelector:@selector(centerImageInTabBarView:)]) {
        [self.centerButton setImage:[self.dataSource centerImageInTabBarView:self] forState:UIControlStateNormal];
    }
    
    [self.centerButton addTarget:self action:@selector(centerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    //self.centerButton.adjustsImageWhenHighlighted = YES;  /* 默认为YES */
    
    [self addSubview:self.centerButton];
}

- (void)setupAdditionalTabBarItems {
//    NSArray *leftTBItems = [self.dataSource leftTabBarItemsInTabBarView:self];
//    NSArray *rightTBItems = [self.dataSource rightTabBarItemsInTabBarView:self];
//    
//    NSUInteger numOfLeft = leftTBItems.count;
//    NSUInteger numOfRight = rightTBItems.count;
//    
//    //calculate available space for left and right side
//    CGFloat availableSpaceForAdditionalBarButtonItemLeft = CGRectGetWidth(self.mainView.frame) / 2.f - CGRectGetWidth(self.centerButton.frame) / 2.f - self.tabBarItemsEdgeInsets.left;
//    
//    CGFloat availableSpaceForAdditionalBarButtonItemRight = CGRectGetWidth(self.mainView.frame) / 2.f - CGRectGetWidth(self.centerButton.frame) / 2.f - self.tabBarItemsEdgeInsets.right;
    
//    CGFloat maxWidthForLeftBarButonItem = availableSpaceForAdditionalBarButtonItemLeft / numOfLeft;
//    CGFloat maxWidthForRightBarButonItem = availableSpaceForAdditionalBarButtonItemRight / numOfRight;
}


#pragma mark - Actions

- (void)centerButtonPressed {
    
}



@end
