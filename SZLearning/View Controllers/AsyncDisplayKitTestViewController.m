//
//  AsyncDisplayKitTestViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/18.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "AsyncDisplayKitTestViewController.h"

#import <AsyncDisplayKit/AsyncDisplayKit.h>

#import "BlurbNode.h"
#import "KittenNode.h"
#import "RainbowNode.h"

#import "ASTableViewTestViewController.h"
#import "ASCollectionViewViewController.h"
#import "ASMultiplexImageNodeViewController.h"
#import "ASPlaceholderViewController.h"
#import "SZWPopViewController.h"

@interface AsyncDisplayKitTestViewController ()

///ASImageNode 使用
@property (nonatomic, strong) ASImageNode *imageNode;
///ASTextNode 使用
@property (nonatomic, strong) ASTextNode *shuffleNode;
///<#说明#>
@property (nonatomic, strong) BlurbNode *blurbNode;
///<#说明#>
@property (nonatomic, strong) KittenNode *kittenNode;
///<#说明#>
@property (nonatomic, strong) RainbowNode *rainbowNode;

@end

@implementation AsyncDisplayKitTestViewController



#pragma mark -Life cycle            //生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addView];
    [self addLayout];
}

- (void)addView {
    self.view.backgroundColor = HexColor(@"24b8c5");
    
    /* ASImageNode */
    [self.view addSubview:self.imageNode.view];
    /* ASTextNode */
    [self.view addSubview:self.shuffleNode.view];
    /* ASDisplayNode+Subclasses */
    [self.view addSubview:self.blurbNode.view];
    [self.view addSubview:self.kittenNode.view];
    [self.view addSubview:self.rainbowNode.view];
}

- (void)addLayout {
    [self.imageNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@100);
        make.right.equalTo(@(-100));
        make.height.equalTo(@100);
    }];
    
    [self.shuffleNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        CGRect b = self.view.bounds; // convenience
        CGSize size = [_shuffleNode measure:CGSizeMake(b.size.width, FLT_MAX)];
        
        make.width.equalTo(@(size.width));
        make.top.equalTo(self.imageNode.view.mas_bottom).offset(15);
        make.centerX.equalTo(self.imageNode.view.mas_centerX);
        make.height.equalTo(@(size.height));
    }];
    
    [self.blurbNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageNode.view.mas_centerX);
        make.centerY.equalTo(self.rainbowNode.view.mas_bottom).offset(30);
        
        CGRect b = self.view.bounds; // convenience
        CGSize size = [_blurbNode measure:CGSizeMake(b.size.width, FLT_MAX)];
        make.width.equalTo(@(size.width));
        make.height.equalTo(@(size.height));
    }];
    
    [self.kittenNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageNode.view.mas_centerX);
        make.top.equalTo(self.blurbNode.view.mas_bottom).offset(15);
        
        CGRect b = self.view.bounds; // convenience
        CGSize size = [_kittenNode measure:CGSizeMake(b.size.width, FLT_MAX)];
        make.width.equalTo(@(size.width));
        make.height.equalTo(@(size.height));
    }];
    
    [self.rainbowNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(@100);
        make.top.equalTo(self.shuffleNode.view.mas_bottom).offset(15);
        make.right.equalTo(@(-100));
    }];
}

#pragma mark -Delegate              //所有代理方法  顺序


#pragma mark -Event response        //事件回应

- (void)buttonTapped:(id)sender {
    NSLog(@"tapped!");
    
    if (sender == _imageNode) {
        [self.navigationController pushViewController:[[SZWPopViewController alloc] init] animated:YES];
    }
    
    if (sender == _shuffleNode) {
        /* ASTableView test */
        [self.navigationController pushViewController:[[ASTableViewTestViewController alloc] init] animated:YES];
        //[self presentPopupViewController:[[ASTableViewTestViewController alloc] init] animationType:MJPopupViewAnimationSlideRightRight];
    }
    
}


#pragma mark -Private methods       //私有方法


#pragma mark -Getters and Setters   //设置方法

- (ASImageNode *)imageNode {
    if (!_imageNode) {
        _imageNode = [[ASImageNode alloc] init];
        _imageNode.backgroundColor = [UIColor blueColor];
        _imageNode.placeholderColor = [UIColor greenColor];
        _imageNode.image = [UIImage imageNamed:@"sky.jpg"];
        _imageNode.cornerRadius = 8;
        _imageNode.borderColor = [UIColor whiteColor].CGColor;
        _imageNode.borderWidth = 1;
        _imageNode.clipsToBounds = YES;
        [_imageNode addTarget:self action:@selector(buttonTapped:) forControlEvents:ASControlNodeEventTouchUpInside];
    }
    return _imageNode;
}

- (ASTextNode *)shuffleNode {
    if (!_shuffleNode) {
        _shuffleNode = [[ASTextNode alloc] init];
        
        NSDictionary *attrs = @{
                                NSFontAttributeName: [UIFont systemFontOfSize:18.0f],
                                NSForegroundColorAttributeName: [UIColor redColor],
                                };
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"shuffle"
                                                                     attributes:attrs];
        _shuffleNode.backgroundColor = [UIColor blueColor];
        _shuffleNode.attributedString = string;
        _shuffleNode.userInteractionEnabled = YES;
        [_shuffleNode addTarget:self action:@selector(buttonTapped:) forControlEvents:ASControlNodeEventTouchUpInside];
        
        //[_shuffleNode.view sz_visuallyExtendHitTestSizeByWidth:10 andHeight:10];
    }
    return _shuffleNode;
}

- (BlurbNode *)blurbNode {
    if (!_blurbNode) {
        _blurbNode = [[BlurbNode alloc] init];
        _blurbNode.backgroundColor = [UIColor yellowColor];
    }
    return _blurbNode;
}

- (KittenNode *)kittenNode {
    if (!_kittenNode) {
        _kittenNode = [[KittenNode alloc] initWithKittenOfSize:CGSizeZero];
        _kittenNode.backgroundColor = [UIColor blueColor];
    }
    return _kittenNode;
}

- (RainbowNode *)rainbowNode {
    if (!_rainbowNode) {
        _rainbowNode = [[RainbowNode alloc] init];
        _rainbowNode.orientation = RainbowOrientationHorizontal;
    }
    return _rainbowNode;
}


@end











